 ;; Basic Staking Platform - Minimal Example
;; Allows users to stake STX and check their staked balance

(define-map stakes principal uint)
(define-data-var total-staked uint u0)

;; Function 1: Stake STX
(define-public (stake (amount uint))
  (begin
    (asserts! (> amount u0) (err u100)) ;; Invalid amount
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    (map-set stakes tx-sender
             (+ (default-to u0 (map-get? stakes tx-sender)) amount))
    (var-set total-staked (+ (var-get total-staked) amount))
    (ok true)))

;; Function 2: Get staked balance of the sender
(define-read-only (get-stake-balance)
  (ok (default-to u0 (map-get? stakes tx-sender))))
