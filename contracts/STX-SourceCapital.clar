;; Open Source Project Funding Contract
;; This contract allows users to create and fund open source projects

;; Error codes
(define-constant ERR-UNAUTHORIZED-ACCESS (err u1))
(define-constant ERR-PROJECT-DOES-NOT-EXIST (err u2))
(define-constant ERR-PROJECT-ALREADY-FUNDED (err u3))
(define-constant ERR-INSUFFICIENT-BALANCE (err u4))
(define-constant ERR-INVALID-FUNDING-AMOUNT (err u5))
(define-constant ERR-MILESTONE-DOES-NOT-EXIST (err u6))
(define-constant ERR-MILESTONE-INCOMPLETE (err u7))
(define-constant ERR-INVALID-PROJECT-TITLE (err u8))
(define-constant ERR-INVALID-PROJECT-DESCRIPTION (err u9))
(define-constant ERR-INVALID-MILESTONE-TITLE (err u10))
(define-constant ERR-INVALID-MILESTONE-DESCRIPTION (err u11))
(define-constant ERR-INVALID-DEADLINE (err u12))
(define-constant ERR-INVALID-PROJECT-ID (err u13))
(define-constant ERR-INVALID-MILESTONE-ID (err u14))

;; Data variables
(define-data-var contract-administrator principal tx-sender)
(define-map open-source-projects 
    { project-identifier: uint }
    {
        project-creator: principal,
        project-title: (string-ascii 100),
        project-description: (string-utf8 500),
        target-funding-amount: uint,
        total-funds-raised: uint,
        project-status: (string-ascii 20),
        project-creation-block: uint
    }
)

(define-map project-development-milestones
    { project-identifier: uint, milestone-identifier: uint }
    {
        milestone-title: (string-ascii 100),
        milestone-description: (string-utf8 500),
        milestone-completion-deadline: uint,
        milestone-funding-amount: uint,
        milestone-status: (string-ascii 20)
    }
)

(define-map project-funding-contributors
    { project-identifier: uint, funding-contributor: principal }
    { contribution-amount: uint }
)

;; Counter for project IDs
(define-data-var next-project-identifier uint u0)

;; Helper functions for validation
(define-private (is-valid-string-ascii (value (string-ascii 100)))
    (> (len value) u0)
)

(define-private (is-valid-string-utf8 (value (string-utf8 500)))
    (> (len value) u0)
)

(define-private (is-valid-project-id (project-id uint))
    (and 
        (> project-id u0)
        (<= project-id (var-get next-project-identifier))
    )
)

(define-private (is-valid-milestone-id (milestone-id uint))
    (> milestone-id u0)
)

(define-private (is-valid-deadline (deadline uint))
    (>= deadline block-height)
)

;; Initialize contract
(define-public (initialize-contract)
    (begin
        (asserts! (is-eq tx-sender (var-get contract-administrator)) ERR-UNAUTHORIZED-ACCESS)
        (ok true)
    )
)

;; Create a new project
(define-public (create-open-source-project 
                (project-title (string-ascii 100)) 
                (project-description (string-utf8 500))
                (target-funding-amount uint))
    (begin
        ;; Validate inputs
        (asserts! (is-valid-string-ascii project-title) ERR-INVALID-PROJECT-TITLE)
        (asserts! (is-valid-string-utf8 project-description) ERR-INVALID-PROJECT-DESCRIPTION)
        (asserts! (> target-funding-amount u0) ERR-INVALID-FUNDING-AMOUNT)

        (let ((new-project-identifier (+ (var-get next-project-identifier) u1)))
            (map-insert open-source-projects
                { project-identifier: new-project-identifier }
                {
                    project-creator: tx-sender,
                    project-title: project-title,
                    project-description: project-description,
                    target-funding-amount: target-funding-amount,
                    total-funds-raised: u0,
                    project-status: "active",
                    project-creation-block: block-height
                }
            )
            (var-set next-project-identifier new-project-identifier)
            (ok new-project-identifier)
        )
    )
)
