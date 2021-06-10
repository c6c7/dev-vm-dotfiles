(cons* (channel
        (name 'flat)
        (url "https://github.com/flatwhatson/guix-channel.git")
        (introduction
         (make-channel-introduction
          "33f86a4b48205c0dc19d7c036c85393f0766f806"
          (openpgp-fingerprint
           "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))
       (channel
        (name 'chckyn)
        (url "https://github.com/chckyn/guix-channel.git")
        (branch "main")
        (introduction
         (make-channel-introduction
          "daa642fbaa53e9b6f1cfd22ea013e5fdf4e17e3a"
          (openpgp-fingerprint
           "2116 4C25 323C EAF7 611E  49E6 9CFB 4F28 C311 D53D"))))
       %default-channels)
