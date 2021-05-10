;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (gnu packages screen))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (host-name "pike-place")
  (timezone "America/Los_Angeles")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "us" "colemak"))

  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/dev/sdf")
      (keyboard-layout keyboard-layout)))

  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device (file-system-label "guix-root"))
             (type "ext4"))
           %base-file-systems))

  (users (cons* (user-account
                  (name "c")
                  (comment "Charles Celerier")
                  (group "users")
                  (home-directory "/home/c")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages (cons screen %base-packages))
  (sudoers-file (plain-file "sudoers" "\
root ALL=(ALL) ALL
%wheel ALL=NOPASSWD: ALL\n"))
  (services
    (append
      (list (service dhcp-client-service-type)
            (service openssh-service-type
		     (openssh-configuration
		       (x11-forwarding? #f)
		       (permit-root-login #f)
		       (allow-empty-passwords? #t)
		       (authorized-keys
			 `(("c" ,(local-file "macbook-air-2020.pub"))))))
            )
      %base-services)))
