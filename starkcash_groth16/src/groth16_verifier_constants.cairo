use garaga::definitions::{E12D, G1Point, G2Line, G2Point, u288, u384};
use garaga::groth16::Groth16VerifyingKey;

pub const N_PUBLIC_INPUTS: usize = 6;

pub const vk: Groth16VerifyingKey = Groth16VerifyingKey {
    alpha_beta_miller_loop_result: E12D {
        w0: u288 {
            limb0: 0xfe609cb584e05535d648c555,
            limb1: 0xd6868eb2d701a2f8bfc0662e,
            limb2: 0x112036f7f6d0b13c,
        },
        w1: u288 {
            limb0: 0x349831f75a954f6d0fbb7a13,
            limb1: 0xa50a418c0fdbb4396b1a3f30,
            limb2: 0x1184e27175ab9d2b,
        },
        w2: u288 {
            limb0: 0x48a3a8fa6e9572877dcad9f5,
            limb1: 0xd0fef52b8e2204589513adad,
            limb2: 0xd58e3b4f8fb7833,
        },
        w3: u288 {
            limb0: 0x861d8b5bee2a6fde0544a112,
            limb1: 0x38d7ba5edb7dfe94f2586e76,
            limb2: 0x1d65c469562e2533,
        },
        w4: u288 {
            limb0: 0xfdbf5ae8fa2dc21fe443b497,
            limb1: 0x739effbb177f57121b737091,
            limb2: 0x1744eee52d9a6726,
        },
        w5: u288 {
            limb0: 0x1d2c34dd27498f0a85d317a9,
            limb1: 0x8e35d7516a79b3509271f1cf,
            limb2: 0x10aa245f7b7fbda8,
        },
        w6: u288 {
            limb0: 0x78b18e034e6ee5b3f65f9e74,
            limb1: 0x395bc0ef53f8e631bfec4620,
            limb2: 0x200076e1cdb85f1,
        },
        w7: u288 {
            limb0: 0xb9234662eacd8366044ce9ed,
            limb1: 0xa7134178e42a52c90655472b,
            limb2: 0x23fafdab5bc14e47,
        },
        w8: u288 {
            limb0: 0x608ec3ca43deb41058b02b49,
            limb1: 0x5f6788b302a055189a0f4942,
            limb2: 0x251e068d93844247,
        },
        w9: u288 {
            limb0: 0x49df5e73f7bf0aa1ad64d7e9,
            limb1: 0xd1319fd1cbe49c0e06c44a4a,
            limb2: 0x24921992b9f08fd4,
        },
        w10: u288 {
            limb0: 0xbe692fb7690a18aa8e536886,
            limb1: 0x2e757adc58e5b29e0c396705,
            limb2: 0x2a4303b89265ffb1,
        },
        w11: u288 {
            limb0: 0x29a413aab979203b43f5bb6f,
            limb1: 0x28bfd920f263cf45fd5f7b29,
            limb2: 0xa37c0a391e79c07,
        },
    },
    gamma_g2: G2Point {
        x0: u384 {
            limb0: 0xf75edadd46debd5cd992f6ed,
            limb1: 0x426a00665e5c4479674322d4,
            limb2: 0x1800deef121f1e76,
            limb3: 0x0,
        },
        x1: u384 {
            limb0: 0x35a9e71297e485b7aef312c2,
            limb1: 0x7260bfb731fb5d25f1aa4933,
            limb2: 0x198e9393920d483a,
            limb3: 0x0,
        },
        y0: u384 {
            limb0: 0xc43d37b4ce6cc0166fa7daa,
            limb1: 0x4aab71808dcb408fe3d1e769,
            limb2: 0x12c85ea5db8c6deb,
            limb3: 0x0,
        },
        y1: u384 {
            limb0: 0x70b38ef355acdadcd122975b,
            limb1: 0xec9e99ad690c3395bc4b3133,
            limb2: 0x90689d0585ff075,
            limb3: 0x0,
        },
    },
    delta_g2: G2Point {
        x0: u384 {
            limb0: 0xe2054d92e3e27fd77b55c2c6,
            limb1: 0x19bc6910febbdaa719732f8c,
            limb2: 0x13ba954d62075050,
            limb3: 0x0,
        },
        x1: u384 {
            limb0: 0xdc979ef2de69b6f4ac0ace5,
            limb1: 0x2fcb1e98df9c8adba3bea039,
            limb2: 0x12bf9b4e896e3935,
            limb3: 0x0,
        },
        y0: u384 {
            limb0: 0x880bd7b7fc0bdc30ff582871,
            limb1: 0xeeaa581fdcbe386d6867fa64,
            limb2: 0x9488d8767fca89,
            limb3: 0x0,
        },
        y1: u384 {
            limb0: 0x67fd16404fae8e430e95b306,
            limb1: 0x3d442822b6f93b8d095a2542,
            limb2: 0xe51628d76ea2ae4,
            limb3: 0x0,
        },
    },
};

pub const ic: [G1Point; 7] = [
    G1Point {
        x: u384 {
            limb0: 0x468932f190e7f189eb8556ff,
            limb1: 0x8c1d508629612f5a737a65d8,
            limb2: 0x303434bae4899a57,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0xc05aa9add2692eb3df49f736,
            limb1: 0x9a877b539d23a57a6cf0edcb,
            limb2: 0x1e2c6ea0d2f0cfd2,
            limb3: 0x0,
        },
    },
    G1Point {
        x: u384 {
            limb0: 0x99eb17626daac4a76fa00a9f,
            limb1: 0xf6bc9ee6c98bcf37c242808f,
            limb2: 0x47195203490cbe3,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0x7a0664cd97bdfa6ce1c828e9,
            limb1: 0x54a2712202c9e1689d10795f,
            limb2: 0x1adc4e0f99a79d9c,
            limb3: 0x0,
        },
    },
    G1Point {
        x: u384 {
            limb0: 0xc33b6d9b8397f6645caae91e,
            limb1: 0xd6542da175ddb2359ad4ca98,
            limb2: 0xfdf9cca909ae29a,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0xbac3044536c80116c2e77c81,
            limb1: 0xce4fdcfe33e2eba6aac6c806,
            limb2: 0x22f9e8af597fe96c,
            limb3: 0x0,
        },
    },
    G1Point {
        x: u384 {
            limb0: 0x3c5042e9793693f30f427875,
            limb1: 0x56abaa8d4095364d0f9312e9,
            limb2: 0xdab9148c3d4feb8,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0x37e68960df9de72304b40077,
            limb1: 0xc72d76d1bd9a524344638f16,
            limb2: 0x2dcfcd7501e2b778,
            limb3: 0x0,
        },
    },
    G1Point {
        x: u384 {
            limb0: 0xee82fe8c767fc48ce30646fa,
            limb1: 0x4d67e3e39a9677472338c47c,
            limb2: 0x1521a62821f5f322,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0x3e0cbcc8c0f0bed8cd3a05f2,
            limb1: 0xa282c5bea1da54cc75fb2b7d,
            limb2: 0x1588bac5feadfa7d,
            limb3: 0x0,
        },
    },
    G1Point {
        x: u384 {
            limb0: 0x18a97c911f10481a483b91cc,
            limb1: 0x1a2dd2d1a57ca275b791b438,
            limb2: 0x1a52825388f030fa,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0x3c66d689fa9d2de0be03095f,
            limb1: 0x7e0ff4f36f074d7832d6c0c,
            limb2: 0x843a459c341e7c6,
            limb3: 0x0,
        },
    },
    G1Point {
        x: u384 {
            limb0: 0xf4fb93baee2abc8e5bd5b6fa,
            limb1: 0x15a3772d7e6359643b3105ce,
            limb2: 0xad7393ca52e55df,
            limb3: 0x0,
        },
        y: u384 {
            limb0: 0x5d3a2cb47f5c7c720a448a5f,
            limb1: 0x218dacd484d8cf533e45742c,
            limb2: 0x28a071dff2cc4baa,
            limb3: 0x0,
        },
    },
];


pub const precomputed_lines: [G2Line; 176] = [
    G2Line {
        r0a0: u288 {
            limb0: 0x4d347301094edcbfa224d3d5,
            limb1: 0x98005e68cacde68a193b54e6,
            limb2: 0x237db2935c4432bc,
        },
        r0a1: u288 {
            limb0: 0x6b4ba735fba44e801d415637,
            limb1: 0x707c3ec1809ae9bafafa05dd,
            limb2: 0x124077e14a7d826a,
        },
        r1a0: u288 {
            limb0: 0x49a8dc1dd6e067932b6a7e0d,
            limb1: 0x7676d0000961488f8fbce033,
            limb2: 0x3b7178c857630da,
        },
        r1a1: u288 {
            limb0: 0x98c81278efe1e96b86397652,
            limb1: 0xe3520b9dfa601ead6f0bf9cd,
            limb2: 0x2b17c2b12c26fdd0,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfc1d0a659f7dafba77974496,
            limb1: 0x322038d38a6095a736319163,
            limb2: 0x9beb67281bd2fbb,
        },
        r0a1: u288 {
            limb0: 0xbbb882d99e343596ce9bb2fb,
            limb1: 0x5879e71f58e5ea7276866b68,
            limb2: 0x5476c0d596f7a3e,
        },
        r1a0: u288 {
            limb0: 0xadc784d758fee4445418c555,
            limb1: 0xffe30758b79eb418936a32f4,
            limb2: 0x73fd4968e771475,
        },
        r1a1: u288 {
            limb0: 0x10b1456c45c4604848e3e69e,
            limb1: 0x57e278cc222681053118e316,
            limb2: 0x279697a4e1d45669,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1b3d578c32d1af5736582972,
            limb1: 0x204fe74db6b371d37e4615ab,
            limb2: 0xce69bdf84ed6d6d,
        },
        r0a1: u288 {
            limb0: 0xfd262357407c3d96bb3ba710,
            limb1: 0x47d406f500e66ea29c8764b3,
            limb2: 0x1e23d69196b41dbf,
        },
        r1a0: u288 {
            limb0: 0x1ec8ee6f65402483ad127f3a,
            limb1: 0x41d975b678200fce07c48a5e,
            limb2: 0x2cad36e65bbb6f4f,
        },
        r1a1: u288 {
            limb0: 0xcfa9b8144c3ea2ab524386f5,
            limb1: 0xd4fe3a18872139b0287570c3,
            limb2: 0x54c8bc1b50aa258,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb5ee22ba52a7ed0c533b7173,
            limb1: 0xbfa13123614ecf9c4853249b,
            limb2: 0x6567a7f6972b7bb,
        },
        r0a1: u288 {
            limb0: 0xcf422f26ac76a450359f819e,
            limb1: 0xc42d7517ae6f59453eaf32c7,
            limb2: 0x899cb1e339f7582,
        },
        r1a0: u288 {
            limb0: 0x9f287f4842d688d7afd9cd67,
            limb1: 0x30af75417670de33dfa95eda,
            limb2: 0x1121d4ca1c2cab36,
        },
        r1a1: u288 {
            limb0: 0x7c4c55c27110f2c9a228f7d8,
            limb1: 0x8f14f6c3a2e2c9d74b347bfe,
            limb2: 0x83ef274ba7913a5,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6c54c0279ca2dc5c60e5b8b1,
            limb1: 0x86300ce2f720c2b6614fd92d,
            limb2: 0x26a598005f74706e,
        },
        r0a1: u288 {
            limb0: 0xacb947b39dec568009e14a4c,
            limb1: 0x5fd65e97289b6deb20faff28,
            limb2: 0x2b1ce26587c225eb,
        },
        r1a0: u288 {
            limb0: 0xbaaa45b5e321a7d2846437f2,
            limb1: 0xb86d3e5dc9e2a4450417379c,
            limb2: 0x292479dc52ba8bb3,
        },
        r1a1: u288 {
            limb0: 0x57c08520f65c2bce8f9916a9,
            limb1: 0x606dccea5f5ad7586668877b,
            limb2: 0x8cdb6cdff5d49c0,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xac01b6a16c5da242927479d7,
            limb1: 0xd9aeb31da5100d0788e4badf,
            limb2: 0x9013c545a97f65f,
        },
        r0a1: u288 {
            limb0: 0xe1022441c608a5b2e0c56a79,
            limb1: 0x8de510fbb1d728855ddcf21b,
            limb2: 0x293671c858dc0ad2,
        },
        r1a0: u288 {
            limb0: 0x2c26a7a485a748720e249319,
            limb1: 0x10e654bf0d07df1eb20b16eb,
            limb2: 0x7d21206e6a5fdfc,
        },
        r1a1: u288 {
            limb0: 0xee020aa9d28a7ab37692a91d,
            limb1: 0x7790a9c858adab06282a19a6,
            limb2: 0x163c43871c0ea6a1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfc23a674d089e9cfdefb1db8,
            limb1: 0x9ddfd61d289b65a9b4254476,
            limb2: 0x1e2f561324ef4447,
        },
        r0a1: u288 {
            limb0: 0xf67a6a9e31f6975b220642ea,
            limb1: 0xccd852893796296e4d1ed330,
            limb2: 0x94ff1987d19b62,
        },
        r1a0: u288 {
            limb0: 0x360c2a5aca59996d24cc1947,
            limb1: 0x66c2d7d0d176a3bc53f386e8,
            limb2: 0x2cfcc62a17fbeecb,
        },
        r1a1: u288 {
            limb0: 0x2ddc73389dd9a9e34168d8a9,
            limb1: 0xae9afc57944748b835cbda0f,
            limb2: 0x12f0a1f8cf564067,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc847992fb6b15b2d5eda4508,
            limb1: 0xdc73e4ff40d3ea9f2e08f42b,
            limb2: 0x2b4d0f47972c92da,
        },
        r0a1: u288 {
            limb0: 0xc64503af5ccf92e8afb4405a,
            limb1: 0x93ad6a30c500bb8062677b66,
            limb2: 0xc2ff3a340963f6a,
        },
        r1a0: u288 {
            limb0: 0x8e2d257965b65ead1cea878e,
            limb1: 0x1b5261c396f9a007fcf35a3f,
            limb2: 0x24195d8bccce1db4,
        },
        r1a1: u288 {
            limb0: 0x6a2c557d5fb7cb438ca8a74e,
            limb1: 0xaa5704b6850fea53c9b7ab6c,
            limb2: 0xe62f3e7ec93b27a,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9c963c4bdade6ce3d460b077,
            limb1: 0x1738311feefc76f565e34e8a,
            limb2: 0x1aae0d6c9e9888ad,
        },
        r0a1: u288 {
            limb0: 0x9272581fdf80b045c9c3f0a,
            limb1: 0x3946807b0756e87666798edb,
            limb2: 0x2bf6eeda2d8be192,
        },
        r1a0: u288 {
            limb0: 0x3e957661b35995552fb475de,
            limb1: 0xd8076fa48f93f09d8128a2a8,
            limb2: 0xb6f87c3f00a6fcf,
        },
        r1a1: u288 {
            limb0: 0xcf17d6cd2101301246a8f264,
            limb1: 0x514d04ad989b91e697aa5a0e,
            limb2: 0x175f17bbd0ad1219,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x894bc18cc70ca1987e3b8f9f,
            limb1: 0xd4bfa535181f0f8659b063e3,
            limb2: 0x19168d524164f463,
        },
        r0a1: u288 {
            limb0: 0x850ee8d0e9b58b82719a6e92,
            limb1: 0x9fc4eb75cbb027c137d48341,
            limb2: 0x2b2f8a383d944fa0,
        },
        r1a0: u288 {
            limb0: 0x5451c8974a709483c2b07fbd,
            limb1: 0xd7e09837b8a2a3b78e7fe525,
            limb2: 0x347d96be5e7fa31,
        },
        r1a1: u288 {
            limb0: 0x823f2ba2743ee254e4c18a1e,
            limb1: 0x6a61af5db035c443ed0f8172,
            limb2: 0x1e840eee275d1063,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x73272a92084b1447bbab9b49,
            limb1: 0x8cbe65b171a43da0613241c1,
            limb2: 0x14f92b38eac1246d,
        },
        r0a1: u288 {
            limb0: 0x9d1418cf9e4d54c89a5722a,
            limb1: 0xaa78ff498d4a2c1088d56afc,
            limb2: 0x29aeab8bba5df7ec,
        },
        r1a0: u288 {
            limb0: 0xe3dd4177e35d8ec989d11b66,
            limb1: 0x336117304f6c558c7363f9c,
            limb2: 0x1b68321136edacdd,
        },
        r1a1: u288 {
            limb0: 0x11bd9d2abe2d3d160d628009,
            limb1: 0xf1d6c4bd8fbb1d8572cb4384,
            limb2: 0x1e7cc4e8ce2ff933,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf49fa1d645feb4dd77e29108,
            limb1: 0xa79cbbe687a54216d08d4c75,
            limb2: 0x15df027f362d6957,
        },
        r0a1: u288 {
            limb0: 0xa5e204f460eec1baa9accd4b,
            limb1: 0x1f2c66b3564174ec0a14b6d1,
            limb2: 0x2c753c4693d6c589,
        },
        r1a0: u288 {
            limb0: 0x59fb8050396548a37a97507d,
            limb1: 0xba6005faedff38182724a7d5,
            limb2: 0x1e2fcdaf322b43ab,
        },
        r1a1: u288 {
            limb0: 0xe372fc11e1406ded0f11f866,
            limb1: 0x35b442beb961bed9038becee,
            limb2: 0x15f872572ffe8949,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x18d630598e58bb5d0102b30e,
            limb1: 0x9767e27b02a8da37411a2787,
            limb2: 0x100a541662b9cd7c,
        },
        r0a1: u288 {
            limb0: 0x4ca7313df2e168e7e5ea70,
            limb1: 0xd49cce6abd50b574f31c2d72,
            limb2: 0x78a2afbf72317e7,
        },
        r1a0: u288 {
            limb0: 0x6d99388b0a1a67d6b48d87e0,
            limb1: 0x1d8711d321a193be3333bc68,
            limb2: 0x27e76de53a010ce1,
        },
        r1a1: u288 {
            limb0: 0x77341bf4e1605e982fa50abd,
            limb1: 0xc5cf10db170b4feaaf5f8f1b,
            limb2: 0x762adef02274807,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x52955617338e76761d38466,
            limb1: 0xda1c9309c949a8681f5a60ee,
            limb2: 0x237790430e9389fa,
        },
        r0a1: u288 {
            limb0: 0x29b6cb4acb15c2beb2ecc0cf,
            limb1: 0xaa9501233279cbc46c40eafa,
            limb2: 0x4e8922fc82a21cf,
        },
        r1a0: u288 {
            limb0: 0xfecde5b710b64f5d6480906d,
            limb1: 0x4e9e6ebd2ccc1dab9ee1d465,
            limb2: 0xa648c5a5863fb74,
        },
        r1a1: u288 {
            limb0: 0x6db5e2a976acf794fc97db1a,
            limb1: 0x49f8e48fbfef44208284fafe,
            limb2: 0xb9f9f12b8496435,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa137b991ba9048aee9fa0bc7,
            limb1: 0xf5433785c186cd1100ab6b80,
            limb2: 0xab519fd7cf8e7f9,
        },
        r0a1: u288 {
            limb0: 0x90832f45d3398c60aa1a74e2,
            limb1: 0x17f7ac209532723f22a344b,
            limb2: 0x23db979f8481c5f,
        },
        r1a0: u288 {
            limb0: 0x723b0e23c2808a5d1ea6b11d,
            limb1: 0x3030030d26411f84235c3af5,
            limb2: 0x122e78da5509eddb,
        },
        r1a1: u288 {
            limb0: 0xf1718c1e21a9bc3ec822f319,
            limb1: 0xf5ee6dfa3bd3272b2f09f0c7,
            limb2: 0x5a29c1e27616b34,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd2f7b22224f5e78bff358825,
            limb1: 0xcbb03dbf2ef8ea197b012de,
            limb2: 0x546483fb9df954a,
        },
        r0a1: u288 {
            limb0: 0x45e1d28a841871cdffa1546a,
            limb1: 0x1936f2071b0c224617b284ee,
            limb2: 0x252726b49b3b6b28,
        },
        r1a0: u288 {
            limb0: 0x27f048ec6108343a91fee7ac,
            limb1: 0xb9e2bfb7320a114627c4cf99,
            limb2: 0x1f54d2e599831396,
        },
        r1a1: u288 {
            limb0: 0x995040590556797dbb2825c2,
            limb1: 0xf9bb2e866809039c053a3602,
            limb2: 0x1be93ca2745a3aa2,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbc1ede480873fceb8739511e,
            limb1: 0xd5a60533bd0ce7869efbc15,
            limb2: 0x182c17d793eba74d,
        },
        r0a1: u288 {
            limb0: 0x83bf38d91876ad8999516bc2,
            limb1: 0x7756322ea3dc079289d51f2d,
            limb2: 0x1d0f6156a89a4244,
        },
        r1a0: u288 {
            limb0: 0x6aba652f197be8f99707b88c,
            limb1: 0xbf94286c245794ea0f562f32,
            limb2: 0x25a358967a2ca81d,
        },
        r1a1: u288 {
            limb0: 0xc028cbff48c01433e8b23568,
            limb1: 0xd2e791f5772ed43b056beba1,
            limb2: 0x83eb38dff4960e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x73511a29cc5fe5b7cbe49edd,
            limb1: 0xe5f900090e5db4529f7dfe19,
            limb2: 0x2b01ea52fff1d040,
        },
        r0a1: u288 {
            limb0: 0x40a5c305c0b992388adf0b0,
            limb1: 0x64e9b76cbe54a57a441a0512,
            limb2: 0x28963bfbeda417e1,
        },
        r1a0: u288 {
            limb0: 0x4646ac7d8f9f531bbdaee33c,
            limb1: 0x9de35110c5fd71593904e0b3,
            limb2: 0x1515de300861e5cf,
        },
        r1a1: u288 {
            limb0: 0x65b6b04a91246169f868cb6b,
            limb1: 0x28ed4290c81e704d913f76a3,
            limb2: 0x2905ca2447c2260,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc2a2b787d8e718e81970db80,
            limb1: 0x5372abeaf56844dee60d6198,
            limb2: 0x131210153a2217d6,
        },
        r0a1: u288 {
            limb0: 0x70421980313e09a8a0e5a82d,
            limb1: 0xf75ca1f68f4b8deafb1d3b48,
            limb2: 0x102113c9b6feb035,
        },
        r1a0: u288 {
            limb0: 0x4654c11d73bda84873de9b86,
            limb1: 0xa67601bca2e595339833191a,
            limb2: 0x1c2b76e439adc8cc,
        },
        r1a1: u288 {
            limb0: 0x9c53a48cc66c1f4d644105f2,
            limb1: 0xa17a18867557d96fb7c2f849,
            limb2: 0x1deb99799bd8b63a,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc32026c56341297fa080790c,
            limb1: 0xe23ad2ff283399133533b31f,
            limb2: 0xa6860f5c968f7ad,
        },
        r0a1: u288 {
            limb0: 0x2966cf259dc612c6a4d8957d,
            limb1: 0xfba87ea86054f3db5774a08f,
            limb2: 0xc73408b6a646780,
        },
        r1a0: u288 {
            limb0: 0x6272ce5976d8eeba08f66b48,
            limb1: 0x7dfbd78fa06509604c0cec8d,
            limb2: 0x181ec0eaa6660e45,
        },
        r1a1: u288 {
            limb0: 0x48af37c1a2343555fbf8a357,
            limb1: 0xa7b5e1e20e64d6a9a9ce8e61,
            limb2: 0x1147dcea39a47abd,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd2dcce8a84f9e188d4d2049a,
            limb1: 0x7febeb381dd2bd82cb879582,
            limb2: 0x279a1e0e4ce76afe,
        },
        r0a1: u288 {
            limb0: 0x12ab4081a7fb93f2e5f0c0fd,
            limb1: 0x35e8cee89b524f0334572f0,
            limb2: 0xd39730472f5efe3,
        },
        r1a0: u288 {
            limb0: 0x81df5dd9e51bf3afc6544a63,
            limb1: 0x27bb480685560e22c2b207b5,
            limb2: 0x26abdf04ee69f9a7,
        },
        r1a1: u288 {
            limb0: 0x59cc5f1a253ee862654d493f,
            limb1: 0x5e942d741f7f5b45e11e24c3,
            limb2: 0x383ae882cafef43,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x15d1de7ea54cacba8e600c0e,
            limb1: 0x217f07c1f05c665726ed9172,
            limb2: 0x2555a947e844889e,
        },
        r0a1: u288 {
            limb0: 0x5fc0b0784f40cc8657b487c1,
            limb1: 0x2d9f5e28c33279089c0bdb8e,
            limb2: 0x1a3f7666211c0f91,
        },
        r1a0: u288 {
            limb0: 0xd09ba8f7666babb759138423,
            limb1: 0xacfe66ad9a115829aaf0b5b,
            limb2: 0x219bee7efd55950f,
        },
        r1a1: u288 {
            limb0: 0x56ad6da6400b40b7edad23e7,
            limb1: 0x999775465a0508468b6989f9,
            limb2: 0x1889b7b671d4ea5,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4033c51e6e469818521cd2ae,
            limb1: 0xb71a4629a4696b2759f8e19e,
            limb2: 0x4f5744e29c1eb30,
        },
        r0a1: u288 {
            limb0: 0xa4f47bbc60cb0649dca1c772,
            limb1: 0x835f427106f4a6b897c6cf23,
            limb2: 0x17ca6ea4855756bb,
        },
        r1a0: u288 {
            limb0: 0x7f844a35c7eeadf511e67e57,
            limb1: 0x8bb54fb0b3688cac8860f10,
            limb2: 0x1c7258499a6bbebf,
        },
        r1a1: u288 {
            limb0: 0x10d269c1779f96946e518246,
            limb1: 0xce6fcef6676d0dacd395dc1a,
            limb2: 0x2cf4c6ae1b55d87d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf14ba77a57c794d64bc838c0,
            limb1: 0x369e260bc935abf6dac8d7fd,
            limb2: 0x2e4c66e6aa1d024e,
        },
        r0a1: u288 {
            limb0: 0x6d51d6a14999753f3fabb0db,
            limb1: 0xbe0b4a4ed702ee3c152df73,
            limb2: 0x1638a20d7b514d08,
        },
        r1a0: u288 {
            limb0: 0xcecf039f44a2793251b5e49f,
            limb1: 0x26f9b2681c5bdd0d2697a821,
            limb2: 0x1626aa96c7e66222,
        },
        r1a1: u288 {
            limb0: 0x4db7daf0dd3eb65ca3045e02,
            limb1: 0x2fa2ea3972361a05757640f6,
            limb2: 0x2b71e586244a7c38,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xab74a6bae36b17b1d2cc1081,
            limb1: 0x904cf03d9d30b1fe9dc71374,
            limb2: 0x14ffdd55685b7d82,
        },
        r0a1: u288 {
            limb0: 0x277f7180b7cf33feded1583c,
            limb1: 0xc029c3968a75b612303c4298,
            limb2: 0x20ef4ba03605cdc6,
        },
        r1a0: u288 {
            limb0: 0xd5a7a27c1baba3791ab18957,
            limb1: 0x973730213d5d70d3e62d6db,
            limb2: 0x24ca121c566eb857,
        },
        r1a1: u288 {
            limb0: 0x9f4c2dea0492f548ae7d9e93,
            limb1: 0xe584b6b251a5227c70c5188,
            limb2: 0x22bcecac2bd5e51b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x340c82974f7221a53fc2f3ac,
            limb1: 0x7146f18cd591d423874996e7,
            limb2: 0xa6d154791056f46,
        },
        r0a1: u288 {
            limb0: 0x70894ea6418890d53b5ee12a,
            limb1: 0x882290cb53b795b0e7c8c208,
            limb2: 0x1b5777dc18b2899b,
        },
        r1a0: u288 {
            limb0: 0x99a0e528d582006a626206b6,
            limb1: 0xb1cf825d80e199c5c9c795b5,
            limb2: 0x2a97495b032f0542,
        },
        r1a1: u288 {
            limb0: 0xc7cf5b455d6f3ba73debeba5,
            limb1: 0xbb0a01235687223b7b71d0e5,
            limb2: 0x250024ac44c35e3f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x86626e311f526fb351735359,
            limb1: 0xcaacdd5dc93810526ab6759e,
            limb2: 0x126f047b32fe9146,
        },
        r0a1: u288 {
            limb0: 0xc8d5917deec69500d84cdaae,
            limb1: 0x26587de7b31cb19548db5ed7,
            limb2: 0x1d285140f6da8838,
        },
        r1a0: u288 {
            limb0: 0x548fc6e05832a498a9f1492f,
            limb1: 0xe6c3ca2d024f1db536917372,
            limb2: 0x14968c702f5b9d0d,
        },
        r1a1: u288 {
            limb0: 0xd5d348fff110168fc57a0177,
            limb1: 0x33f45fb20bfc5c51363d6f73,
            limb2: 0x180ebb0c270dd0bf,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x698d00bb789cad058bff22da,
            limb1: 0x1a288a8ac1eae76d6af4dca4,
            limb2: 0x1cc36d11e91c19fb,
        },
        r0a1: u288 {
            limb0: 0xcb2a89e3cd6ceabe819836ec,
            limb1: 0x11c6819e33fe36c0616ef29e,
            limb2: 0x78351fa62ae2fb1,
        },
        r1a0: u288 {
            limb0: 0x84445588b56b6810e7bacac0,
            limb1: 0xee6670a2f51608d84eddc0ab,
            limb2: 0x123df7315a140adf,
        },
        r1a1: u288 {
            limb0: 0x53def9b9b444998081243eb1,
            limb1: 0xb37ceffbed056dcfa47b3fec,
            limb2: 0x20a79e0fb8dc5ec8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xccf841cf5c1cf8f4a0485e28,
            limb1: 0xb5077662d0ce9d755af1446b,
            limb2: 0x2b08658e9d5ba5cb,
        },
        r0a1: u288 {
            limb0: 0x6ce62184a15685babd77f27f,
            limb1: 0x5ff9bb7d74505b0542578299,
            limb2: 0x7244563488bab2,
        },
        r1a0: u288 {
            limb0: 0xec778048d344ac71275d961d,
            limb1: 0x1273984019753000ad890d33,
            limb2: 0x27c2855e60d361bd,
        },
        r1a1: u288 {
            limb0: 0xa7a0071e22af2f3a79a12da,
            limb1: 0xc84a6fd41c20759ff6ff169a,
            limb2: 0x23e7ef2a308e49d1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xea052c2fa2fa6c7b992e1037,
            limb1: 0x60b26288a491d04a523e31a2,
            limb2: 0x2cdab0abfc07d59d,
        },
        r0a1: u288 {
            limb0: 0x27157964d0a5db65b6ecb811,
            limb1: 0x2b18d72d107802360c99f08f,
            limb2: 0x1776721033cd8dac,
        },
        r1a0: u288 {
            limb0: 0x73ca3ac47eff29a2a79032c9,
            limb1: 0xb47527dac8190ac52fb19dca,
            limb2: 0x1972096fabd1471c,
        },
        r1a1: u288 {
            limb0: 0xbffd668081fc39830bb9b613,
            limb1: 0x73d6b34274129bea4502f908,
            limb2: 0x20b95e6186aed7c8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7105024c431a33683d9d0b9d,
            limb1: 0x12e23637b641ab0e5b322ad8,
            limb2: 0x2918e9e08c764c28,
        },
        r0a1: u288 {
            limb0: 0x26384979d1f5417e451aeabf,
            limb1: 0xacfb499e362291d0b053bbf6,
            limb2: 0x2a6ad1a1f7b04ef6,
        },
        r1a0: u288 {
            limb0: 0xba4db515be70c384080fc9f9,
            limb1: 0x5a983a6afa9cb830fa5b66e6,
            limb2: 0x8cc1fa494726a0c,
        },
        r1a1: u288 {
            limb0: 0x59c9af9399ed004284eb6105,
            limb1: 0xef37f66b058b4c971d9c96b0,
            limb2: 0x2c1839afde65bafa,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x317bb98e35c0eee0d32ffd7c,
            limb1: 0x3c9c0cf7b79c1297ea0c8575,
            limb2: 0x1d9319238c71666a,
        },
        r0a1: u288 {
            limb0: 0xc7dc1496e8064d6e9287fd72,
            limb1: 0xb89a477581b6f7a7bcad8e9f,
            limb2: 0x1ad1e07e19506d68,
        },
        r1a0: u288 {
            limb0: 0x13c00d93ed43c7c20004eb49,
            limb1: 0x5861f7139ee03eb59454c519,
            limb2: 0x2f35a2cbb8990bd2,
        },
        r1a1: u288 {
            limb0: 0x3d25879ee51eb1a2622bc662,
            limb1: 0xb0ad798aa78e0d84c390f36d,
            limb2: 0x23e96c8d28c80a11,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6bf13a27b0f4eb6657abc4b,
            limb1: 0xf78d57f089bffdf07c676bb3,
            limb2: 0x228e4aefbdd738df,
        },
        r0a1: u288 {
            limb0: 0x4f41a40b04ec964619823053,
            limb1: 0xfa3fb44f4a80641a9bb3bc09,
            limb2: 0x29bf29a3d071ec4b,
        },
        r1a0: u288 {
            limb0: 0x83823dcdff02bdc8a0e6aa03,
            limb1: 0x79ac92f113de29251cd73a98,
            limb2: 0x1ccdb791718d144,
        },
        r1a1: u288 {
            limb0: 0xa074add9d066db9a2a6046b6,
            limb1: 0xef3a70034497456c7d001a5,
            limb2: 0x27d09562d815b4a6,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf961c0b9e6994cbb3a872108,
            limb1: 0x675508a461cca221aa056d98,
            limb2: 0x2d985c2cc37c5d83,
        },
        r0a1: u288 {
            limb0: 0x9e9574a1a0fc127951bfc8b3,
            limb1: 0x4041b621a2b57d981030dc85,
            limb2: 0xb5cc734509049c3,
        },
        r1a0: u288 {
            limb0: 0x8465a5b5c4405112d714ebf7,
            limb1: 0x545b4e0cb5689d1fd95fb7d7,
            limb2: 0x279f3a79c0b12b57,
        },
        r1a1: u288 {
            limb0: 0x8443149902904f25e1e3a7df,
            limb1: 0x8baaa44eac218c7241751057,
            limb2: 0x2b075de302921546,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x87a44d343cc761056f4f2eae,
            limb1: 0x18016f16818253360d2c8adf,
            limb2: 0x1bcd5c6e597d735e,
        },
        r0a1: u288 {
            limb0: 0x593d7444c376f6d69289660b,
            limb1: 0x1d6d97020b59cf2e4b38be4f,
            limb2: 0x17133b62617f63a7,
        },
        r1a0: u288 {
            limb0: 0x88cac99869bb335ec9553a70,
            limb1: 0x95bcfa7f7c0b708b4d737afc,
            limb2: 0x1eec79b9db274c09,
        },
        r1a1: u288 {
            limb0: 0xe465a53e9fe085eb58a6be75,
            limb1: 0x868e45cc13e7fd9d34e11839,
            limb2: 0x2b401ce0f05ee6bb,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x83f48fbac5c1b94486c2d037,
            limb1: 0xf95d9333449543de78c69e75,
            limb2: 0x7bca8163e842be7,
        },
        r0a1: u288 {
            limb0: 0x60157b2ff6e4d737e2dac26b,
            limb1: 0x30ab91893fcf39d9dcf1b89,
            limb2: 0x29a58a02490d7f53,
        },
        r1a0: u288 {
            limb0: 0x520f9cb580066bcf2ce872db,
            limb1: 0x24a6e42c185fd36abb66c4ba,
            limb2: 0x309b07583317a13,
        },
        r1a1: u288 {
            limb0: 0x5a4c61efaa3d09a652c72471,
            limb1: 0xfcb2676d6aa28ca318519d2,
            limb2: 0x1405483699afa209,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfb898b8b0acc154ac72b790e,
            limb1: 0xc91984739a7ec073a3132525,
            limb2: 0x252c5d0f383cffb3,
        },
        r0a1: u288 {
            limb0: 0x2e1c5b9568661c1597f12345,
            limb1: 0x170f14107455cc5442cc3aa9,
            limb2: 0x149fdaac7df6fd24,
        },
        r1a0: u288 {
            limb0: 0x35860e9001e9e537ec023be7,
            limb1: 0xe79ec3946e3257971a6712c7,
            limb2: 0x270752096ea92822,
        },
        r1a1: u288 {
            limb0: 0xe038fbd123def8b24214f9ac,
            limb1: 0x83d6a587dcf9fcd5478dd617,
            limb2: 0x285c9a00a9a084f1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf2b3a359d553caf3da752660,
            limb1: 0x52f9f24b9259e37529cc2d70,
            limb2: 0x1edd39d10e74282c,
        },
        r0a1: u288 {
            limb0: 0xf5f109199a659db657d4e86,
            limb1: 0xf32b1fcb0f45705edf0d5327,
            limb2: 0x1188463c2fca2b12,
        },
        r1a0: u288 {
            limb0: 0x7732010f453e5e3be6d9a4e7,
            limb1: 0xa16eedb94d1fa47b431cbdc0,
            limb2: 0x2dafed9dd5eb15c1,
        },
        r1a1: u288 {
            limb0: 0xfc5f91139ffe97e32ac63567,
            limb1: 0x90a28bb9e99242d5d404ebaf,
            limb2: 0x2c59353d6b4001ca,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbfdfdae86101e29da3e869b8,
            limb1: 0xf969a9b961a28b872e56aac2,
            limb2: 0x1afdc719440d90f0,
        },
        r0a1: u288 {
            limb0: 0xee43c995686f13baa9b07266,
            limb1: 0xbfa387a694c641cceee4443a,
            limb2: 0x104d8c02eb7f60c8,
        },
        r1a0: u288 {
            limb0: 0x8d451602b3593e798aecd7fb,
            limb1: 0x69ffbefe7c5ac2cf68e8691e,
            limb2: 0x2ea064a1bc373d28,
        },
        r1a1: u288 {
            limb0: 0x6e7a663073bfe88a2b02326f,
            limb1: 0x5faadb36847ca0103793fa4a,
            limb2: 0x26c09a8ec9303836,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x95357ae7c6b5f7e7e16a7e32,
            limb1: 0xae635b931f30c1a0aebcfa2f,
            limb2: 0x1adf427d44483033,
        },
        r0a1: u288 {
            limb0: 0x4d6ded3387c7186aa6fc355a,
            limb1: 0x5c5f8a06d1745ebeecfd328c,
            limb2: 0xf45ff04bcbb89f3,
        },
        r1a0: u288 {
            limb0: 0x4fbca6334355cc28a2240ea2,
            limb1: 0x2f868507dc549006338418af,
            limb2: 0x1ea4dfeb871446ed,
        },
        r1a1: u288 {
            limb0: 0xfff542044ac981a3716f300a,
            limb1: 0xb8a04b132159848310b95dc5,
            limb2: 0xb96322fc560d804,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3d038747ebac16adc1c50bdd,
            limb1: 0xe3706a783e99f73ac742aa1a,
            limb2: 0x17eac23b00b545ff,
        },
        r0a1: u288 {
            limb0: 0xdc25ff0bd02abcbe502c4e37,
            limb1: 0x39b92e6ebb65e5f2d8504f90,
            limb2: 0x2415b5f61301dff6,
        },
        r1a0: u288 {
            limb0: 0x9cdcb2146d15f37900db82ac,
            limb1: 0x96c3940e2f5c5f8198fadee3,
            limb2: 0x2f662ea79b473fc2,
        },
        r1a1: u288 {
            limb0: 0xc0fb95686de65e504ed4c57a,
            limb1: 0xec396c7c4275d4e493b00713,
            limb2: 0x106d2aab8d90d517,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe02de8c08bd737ae393b6118,
            limb1: 0x13aacfa4ca38f5b72adde99a,
            limb2: 0x2f4e555e354388d6,
        },
        r0a1: u288 {
            limb0: 0x2db0bd87d9ddcac1defaf04b,
            limb1: 0x8c1bb5b73e8583529d9e696,
            limb2: 0x2f0ddec443a190da,
        },
        r1a0: u288 {
            limb0: 0x14e00e09d2635b7c57f7760a,
            limb1: 0xf9b3e06cab13fdfe7cfdab36,
            limb2: 0x452b146abf9878c,
        },
        r1a1: u288 {
            limb0: 0x8684091282199aefc26c5c44,
            limb1: 0x2463b7ca5b5ab4c47adc1370,
            limb2: 0x9759aba3c1e9acf,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x49bbb4d856921e3177c0b5bf,
            limb1: 0x76d84d273694e662bdd5d364,
            limb2: 0xea5dc611bdd369d,
        },
        r0a1: u288 {
            limb0: 0x9e9fc3adc530fa3c5c6fd7fe,
            limb1: 0x114bb0c0e8bd247da41b3883,
            limb2: 0x6044124f85d2ce,
        },
        r1a0: u288 {
            limb0: 0xa6e604cdb4e40982a97c084,
            limb1: 0xef485caa56c7820be2f6b11d,
            limb2: 0x280de6387dcbabe1,
        },
        r1a1: u288 {
            limb0: 0xcaceaf6df5ca9f8a18bf2e1e,
            limb1: 0xc5cce932cc6818b53136c142,
            limb2: 0x12f1cd688682030c,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x37497c23dcf629df58a5fa12,
            limb1: 0x4fcd5534ae47bded76245ac9,
            limb2: 0x1715ab081e32ac95,
        },
        r0a1: u288 {
            limb0: 0x856275471989e2c288e3c83,
            limb1: 0xb42d81a575b89b127a7821a,
            limb2: 0x5fa75a0e4ae3118,
        },
        r1a0: u288 {
            limb0: 0xeb22351e8cd345c23c0a3fef,
            limb1: 0x271feb16d4b47d2267ac9d57,
            limb2: 0x258f9950b9a2dee5,
        },
        r1a1: u288 {
            limb0: 0xb5f75468922dc025ba7916fa,
            limb1: 0x7e24515de90edf1bde4edd9,
            limb2: 0x289145b3512d4d81,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x590be98be8825d660a914c0d,
            limb1: 0x414e14df9b1edf77e3c4e5d3,
            limb2: 0x21bbc923cbbc4d8e,
        },
        r0a1: u288 {
            limb0: 0xc2ad4a1d2252591e3393c0cd,
            limb1: 0x605d458590f136dab69530c2,
            limb2: 0x1f7851d1b18a83e,
        },
        r1a0: u288 {
            limb0: 0x912ea99a12b74f2b821eb438,
            limb1: 0xa5554bf3d965afc7840d3793,
            limb2: 0x1deee375995c0319,
        },
        r1a1: u288 {
            limb0: 0xb04effd67866897375f1a7fa,
            limb1: 0xd4a335a6c3fee52ece1dfa6f,
            limb2: 0x1696abd9b6bd0547,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9ac322c1d0af03ac6b732993,
            limb1: 0xbae50fc03c020ed3244be21f,
            limb2: 0xcdf67d927365607,
        },
        r0a1: u288 {
            limb0: 0xb57f88df4ca49aa39387faaa,
            limb1: 0xeb4da63a87b7a03a5acf81f3,
            limb2: 0x1228d0e201c782ce,
        },
        r1a0: u288 {
            limb0: 0xf6f4d41dd1a96b9c4ff90a78,
            limb1: 0xe093e9a4a58ca45dbdf4ad28,
            limb2: 0x1ff6c60d7d16f2c3,
        },
        r1a1: u288 {
            limb0: 0x90cea77957706955bbf53ac6,
            limb1: 0xacf6f90f59eca2c8da835e8,
            limb2: 0x1b84fcf28c8fd886,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x95b7b32bcc3119c64a62a8de,
            limb1: 0xe07184496f17bbd59a4b7bbd,
            limb2: 0x1708c536fd78b531,
        },
        r0a1: u288 {
            limb0: 0xfa85b5778c77166c1523a75e,
            limb1: 0x89a00c53309a9e525bef171a,
            limb2: 0x2d2287dd024e421,
        },
        r1a0: u288 {
            limb0: 0x31fd0884eaf2208bf8831e72,
            limb1: 0x537e04ea344beb57ee645026,
            limb2: 0x23c7f99715257261,
        },
        r1a1: u288 {
            limb0: 0x8c38b3aeea525f3c2d2fdc22,
            limb1: 0xf838a99d9ec8ed6dcec6a2a8,
            limb2: 0x2973d5159ddc479a,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3f058d8c63fd905d3ca29b42,
            limb1: 0x1f0a90982cc68e4ddcd83e57,
            limb2: 0x240aeaae0783fbfa,
        },
        r0a1: u288 {
            limb0: 0xedfee81d80da310fdf0d0d8,
            limb1: 0xc2208e6de8806cf491bd74d4,
            limb2: 0xb7318be62a476af,
        },
        r1a0: u288 {
            limb0: 0x3c6920c8a24454c634f388fe,
            limb1: 0x23328a006312a722ae09548b,
            limb2: 0x1d2f1c58b80432e2,
        },
        r1a1: u288 {
            limb0: 0xb72980574f7a877586de3a63,
            limb1: 0xcd773b87ef4a29c16784c5ae,
            limb2: 0x1f812c7e22f339c5,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xffb35ad92dd0b8b82258fa43,
            limb1: 0xe4de6d83a9bed97945a8cdc8,
            limb2: 0x1b34373986e53db9,
        },
        r0a1: u288 {
            limb0: 0xae867b8db5cb78b092f4085b,
            limb1: 0xa05ae2bdd763c687f30bfe73,
            limb2: 0x290943a7a47aacce,
        },
        r1a0: u288 {
            limb0: 0xdc25d87ec2a44707598ad9e,
            limb1: 0x9111d8b33a987971b5d0ab07,
            limb2: 0xc15c58d4883224c,
        },
        r1a1: u288 {
            limb0: 0x9b3a24f917735bce39b5058c,
            limb1: 0x605915d067b454b539479d05,
            limb2: 0x71d1a7fdd69364,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9094a9c4710186c73e3e1d4e,
            limb1: 0x744671c34bced078665b68a1,
            limb2: 0x20b6aaf36ecd2214,
        },
        r0a1: u288 {
            limb0: 0xa125ece3c7ab5c2653b7884d,
            limb1: 0x1670d729086925abd5a43e87,
            limb2: 0x25a4277c81fcccf3,
        },
        r1a0: u288 {
            limb0: 0x5ea2b658f354dceab7fe34c6,
            limb1: 0x17e6abdd146a3a79de2c2555,
            limb2: 0x424d9adf165cce0,
        },
        r1a1: u288 {
            limb0: 0x57baddb799693ec1289afeaf,
            limb1: 0xebb7a77e9e3e4074c109b76b,
            limb2: 0x15408778cb1f855,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfeebe92941f95b6ea1d095bb,
            limb1: 0x9c7962eb8bbeb95a9ca7cf50,
            limb2: 0x290bdaf3b9a08dc3,
        },
        r0a1: u288 {
            limb0: 0x686cfa11c9d4b93675495599,
            limb1: 0xb1d69e17b4b5ebf64f0d51e1,
            limb2: 0x2c18bb4bdc2e9567,
        },
        r1a0: u288 {
            limb0: 0x17419b0f6a04bfc98d71527,
            limb1: 0x80eba6ff02787e3de964a4d1,
            limb2: 0x26087bb100e7ff9f,
        },
        r1a1: u288 {
            limb0: 0x17c4ee42c3f612c43a08f689,
            limb1: 0x7276bdda2df6d51a291dba69,
            limb2: 0x40a7220ddb393e1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xad31c92a95509a687a87d11a,
            limb1: 0x63fc5b93b91b06f5af39967c,
            limb2: 0x1f914aa1d343300b,
        },
        r0a1: u288 {
            limb0: 0xd74b61037153d33bc997f583,
            limb1: 0xadabea64bb57514505290187,
            limb2: 0x13e6db85fbc1027b,
        },
        r1a0: u288 {
            limb0: 0xc2a8bbd34d001d9fe527d7ac,
            limb1: 0x4e9f4658cc0f811bfc205a2b,
            limb2: 0x1c7dd519aa907649,
        },
        r1a1: u288 {
            limb0: 0xaf8eb72fd7741a89e3449c15,
            limb1: 0xe793effc03a10ff3aa88d842,
            limb2: 0x240e8405ba3a0ffc,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x830d777c19040571a1d72fd0,
            limb1: 0x651b2c6b8c292020817a633f,
            limb2: 0x268af1e285bc59ff,
        },
        r0a1: u288 {
            limb0: 0xede78baa381c5bce077f443d,
            limb1: 0x540ff96bae21cd8b9ae5438b,
            limb2: 0x12a1fa7e3b369242,
        },
        r1a0: u288 {
            limb0: 0x797c0608e5a535d8736d4bc5,
            limb1: 0x375faf00f1147656b7c1075f,
            limb2: 0xda60fab2dc5a639,
        },
        r1a1: u288 {
            limb0: 0x610d26085cfbebdb30ce476e,
            limb1: 0x5bc55890ff076827a09e8444,
            limb2: 0x14272ee2d25f20b7,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x8cfc4c302e5ee3a1ab71d0cb,
            limb1: 0xb36513d483778bf679793d6,
            limb2: 0xc0b87aae857b6b9,
        },
        r0a1: u288 {
            limb0: 0x533379344c6231efd4b62093,
            limb1: 0x838fa493ecc016429c854e5e,
            limb2: 0xd18152a3cc5b850,
        },
        r1a0: u288 {
            limb0: 0xc9b85e45dc2aa251dce15ec0,
            limb1: 0xfa9dddb01f9581e49fc9137f,
            limb2: 0x68e3cf75be1348b,
        },
        r1a1: u288 {
            limb0: 0x6b335cf8fae335a0df92293d,
            limb1: 0xd1dd9a27e178d9289042f2fb,
            limb2: 0x156578c5b5bf1d47,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd6862e1a4ca3b2baf6f8d8aa,
            limb1: 0x96f9066dded3a3d899025af4,
            limb2: 0x1a98af9f0d48fd3,
        },
        r0a1: u288 {
            limb0: 0x276b417cc61ea259c114314e,
            limb1: 0x464399e5e0037b159866b246,
            limb2: 0x12cc97dcf32896b5,
        },
        r1a0: u288 {
            limb0: 0xef72647f4c2d08fc038c4377,
            limb1: 0x34883cea19be9a490a93cf2b,
            limb2: 0x10d01394daa61ed0,
        },
        r1a1: u288 {
            limb0: 0xdf345239ece3acaa62919643,
            limb1: 0x914780908ece64e763cca062,
            limb2: 0xee2a80dbd2012a3,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1d5a31f4d08a0ebf7e071e00,
            limb1: 0xcd1244dd95dd30005f531f81,
            limb2: 0xb4cb469a2dcf4f1,
        },
        r0a1: u288 {
            limb0: 0x7c5938adaf38b355092de1f1,
            limb1: 0x292ab08995b293abfcba14b,
            limb2: 0x1fd126a2b9f37c67,
        },
        r1a0: u288 {
            limb0: 0x6e9d352b02a7cb771fcc33f9,
            limb1: 0x7754d8536eefda2025a07340,
            limb2: 0x1840289291c35a72,
        },
        r1a1: u288 {
            limb0: 0xe85f465417b7bd758c547b2e,
            limb1: 0xf7f703c3bc55ff8a01fa9365,
            limb2: 0xfa301227880a841,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa21adbaff05c24fc06732713,
            limb1: 0xfd8d33b46097b007cd9ad6e5,
            limb2: 0x3768e1dc6c94c9d,
        },
        r0a1: u288 {
            limb0: 0xccd5a3d7354171377344102e,
            limb1: 0x151961fc80f7550ca80cf611,
            limb2: 0x1b6e5a9e6d7c7927,
        },
        r1a0: u288 {
            limb0: 0xe1e1a1f5e48fb72499dece58,
            limb1: 0x33a37c0bb02c87a6b003a743,
            limb2: 0x174a80cd0fe32566,
        },
        r1a1: u288 {
            limb0: 0x3d5f6a5517ef8b6cbb9d9153,
            limb1: 0x5698138c40f9c14643cefe7e,
            limb2: 0x9cb29c968cd6eb7,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9b33db05a52dfa64826ee613,
            limb1: 0x339ae89c0d590ff9cab3df6b,
            limb2: 0x14b70585d7800e39,
        },
        r0a1: u288 {
            limb0: 0x42939b439e87d6728e8a9d21,
            limb1: 0x5e8b18422b7d4187e928355e,
            limb2: 0x2a5ec6b0ebdc2e89,
        },
        r1a0: u288 {
            limb0: 0xa0465f3f655859f0869fb257,
            limb1: 0xba57f2391f9126c98d6e8d85,
            limb2: 0x1c36c1a31177f2ec,
        },
        r1a1: u288 {
            limb0: 0x5bbf03feea461e6af4b07d52,
            limb1: 0x6da015311d0d28124d5058b6,
            limb2: 0x1cbbd4b0425a78a9,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa4058149e82ea51362b79be4,
            limb1: 0x734eba2621918a820ae44684,
            limb2: 0x110a314a02272b1,
        },
        r0a1: u288 {
            limb0: 0xe2b43963ef5055df3c249613,
            limb1: 0x409c246f762c0126a1b3b7b7,
            limb2: 0x19aa27f34ab03585,
        },
        r1a0: u288 {
            limb0: 0x179aad5f620193f228031d62,
            limb1: 0x6ba32299b05f31b099a3ef0d,
            limb2: 0x157724be2a0a651f,
        },
        r1a1: u288 {
            limb0: 0xa33b28d9a50300e4bbc99137,
            limb1: 0x262a51847049d9b4d8cea297,
            limb2: 0x189acb4571d50692,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x331b3cbdae44e9db109b4a96,
            limb1: 0x448d6dc9c9babeba162ced2,
            limb2: 0x2692b1268b711b32,
        },
        r0a1: u288 {
            limb0: 0xe773a6868e582524ff1d59ef,
            limb1: 0x854c53b472d936e896a2e80a,
            limb2: 0x2bd1dc79b6ebb1f7,
        },
        r1a0: u288 {
            limb0: 0x97ea593b8824bd957c6bf2c5,
            limb1: 0x2bcd40769a6f6ac3ca21d196,
            limb2: 0x272d87e242c8cd50,
        },
        r1a1: u288 {
            limb0: 0x571fd4ef25b079c566327703,
            limb1: 0x8a4301dc2298a282b77f64a,
            limb2: 0x199cdbe9ef59e9b9,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x29bd4381ae4afc677ee37ed6,
            limb1: 0x29ed43453f9a008d9176f004,
            limb2: 0x24134eb915104f43,
        },
        r0a1: u288 {
            limb0: 0x81597f82bb67e90a3e72bdd2,
            limb1: 0xab3bbde5f7bbb4df6a6b5c19,
            limb2: 0x19ac61eea40a367c,
        },
        r1a0: u288 {
            limb0: 0xe30a79342fb3199651aee2fa,
            limb1: 0xf500f028a73ab7b7db0104a3,
            limb2: 0x808b50e0ecb5e4d,
        },
        r1a1: u288 {
            limb0: 0x55f2818453c31d942444d9d6,
            limb1: 0xf6dd80c71ab6e893f2cf48db,
            limb2: 0x13c3ac4488abd138,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbac6104d05931bda837b1195,
            limb1: 0x41d1a445bb5cec4965852407,
            limb2: 0x147e493872459a1d,
        },
        r0a1: u288 {
            limb0: 0x9668d395f0f55916e47f9f9f,
            limb1: 0xd7d6a4d22ea2615fc666948a,
            limb2: 0x11a6640950050c53,
        },
        r1a0: u288 {
            limb0: 0x3f05acf7d0c87db3081537ca,
            limb1: 0xa385c732827290de52b29c7e,
            limb2: 0x195daca5a1493c1a,
        },
        r1a1: u288 {
            limb0: 0xbc40461f2767682281aedf21,
            limb1: 0x306a3589a9ce41f7a62ace3f,
            limb2: 0x1008cc926c303310,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd1464269bbeafa546f559b8f,
            limb1: 0xab7f7dcd1ac32b86979471cf,
            limb2: 0x6a38256ee96f113,
        },
        r0a1: u288 {
            limb0: 0xf14d50984e65f9bc41df4e7e,
            limb1: 0x350aff9be6f9652ad441a3ad,
            limb2: 0x1b1e60534b0a6aba,
        },
        r1a0: u288 {
            limb0: 0x9e98507da6cc50a56f023849,
            limb1: 0xcf8925e03f2bb5c1ba0962dd,
            limb2: 0x2b18961810a62f87,
        },
        r1a1: u288 {
            limb0: 0x3a4c61b937d4573e3f2da299,
            limb1: 0x6f4c6c13fd90f4edc322796f,
            limb2: 0x13f4e99b6a2f025e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x189f8801313126cc10dec113,
            limb1: 0x616a762abb01b439c0fa93b6,
            limb2: 0x1fa27f228802c957,
        },
        r0a1: u288 {
            limb0: 0x39a9f2a47326cee64c6bd163,
            limb1: 0x8db732235974da2f5fdb442a,
            limb2: 0x2b9bd6c4dd5b47e9,
        },
        r1a0: u288 {
            limb0: 0x8cc073304ffeb82010b5f26c,
            limb1: 0x3225db83b601126ce9b6b28b,
            limb2: 0x16c7a2adeed65a4f,
        },
        r1a1: u288 {
            limb0: 0x7f8b60967f6d3a6296ba3190,
            limb1: 0xf51fcf3dd1ac44c156f005a6,
            limb2: 0x1778f533c89a225d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe0115a79120ae892a72f3dcb,
            limb1: 0xec67b5fc9ea414a4020135f,
            limb2: 0x1ee364e12321904a,
        },
        r0a1: u288 {
            limb0: 0xa74d09666f9429c1f2041cd9,
            limb1: 0x57ffe0951f863dd0c1c2e97a,
            limb2: 0x154877b2d1908995,
        },
        r1a0: u288 {
            limb0: 0xcbe5e4d2d2c91cdd4ccca0,
            limb1: 0xe6acea145563a04b2821d120,
            limb2: 0x18213221f2937afb,
        },
        r1a1: u288 {
            limb0: 0xfe20afa6f6ddeb2cb768a5ae,
            limb1: 0x1a3b509131945337c3568fcf,
            limb2: 0x127b5788263a927e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc7715f39cd6c33edd08c0be6,
            limb1: 0x88899d5efd68b566ff9a902b,
            limb2: 0xfea2ac530f9a023,
        },
        r0a1: u288 {
            limb0: 0xf3c954b25a8ee288a4d3a48c,
            limb1: 0x93568c3c20692b1f44bfe748,
            limb2: 0x197f75acf0b2ef5a,
        },
        r1a0: u288 {
            limb0: 0xdf5964b4d6793d248977f570,
            limb1: 0xf045b65beaa5e6132411c43c,
            limb2: 0x28040f0e43b1919a,
        },
        r1a1: u288 {
            limb0: 0x12924120886b5051f209f99b,
            limb1: 0x56995a18e877ca64df52fcd9,
            limb2: 0xe745448074e1b17,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe7c658aecdab4db3c83f7927,
            limb1: 0xfbf162264ca04ee50c70bde8,
            limb2: 0x2a20f4565b7ff885,
        },
        r0a1: u288 {
            limb0: 0x45b1c2f0a1226361f42683c0,
            limb1: 0x9acdd892c48c08de047296bc,
            limb2: 0x27836373108925d4,
        },
        r1a0: u288 {
            limb0: 0xc0ea9294b345e6d4892676a7,
            limb1: 0xcba74eca77086af245d1606e,
            limb2: 0xf20edac89053e72,
        },
        r1a1: u288 {
            limb0: 0x4c92a28f2779a527a68a938c,
            limb1: 0x3a1c3c55ff9d20eac109fab3,
            limb2: 0x21c4a8c524b1ee7d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe5f7c8dd09775fcd9c1c1325,
            limb1: 0x6235d2ec61ce8a24da1c1424,
            limb2: 0x46056ff75322698,
        },
        r0a1: u288 {
            limb0: 0x1b7584b4a3571a4629232f9c,
            limb1: 0x7cf05fafa320d6255af269dd,
            limb2: 0x164c2ea24a4d2c24,
        },
        r1a0: u288 {
            limb0: 0x65a991dcd7d1451ec5e6f205,
            limb1: 0x9173e711151a7e5806ec415e,
            limb2: 0x9ddf41901061974,
        },
        r1a1: u288 {
            limb0: 0xd3fc255fa88e6b30816fb32f,
            limb1: 0x64e457eb7031810f60e05182,
            limb2: 0x6f959591bdd9488,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa68021d593c46246af22559e,
            limb1: 0x5c2cfc5bc4cd1b48f4704134,
            limb2: 0x296066ede1298f8c,
        },
        r0a1: u288 {
            limb0: 0xfe17dd6765eb9b9625eb6a84,
            limb1: 0x4e35dd8e8f6088bb14299f8d,
            limb2: 0x1a380ab2689106e4,
        },
        r1a0: u288 {
            limb0: 0x82bacf337ca09853df42bc59,
            limb1: 0xa15de4ef34a30014c5a2e9ae,
            limb2: 0x243cc0cec53c778b,
        },
        r1a1: u288 {
            limb0: 0xcb2a1bf18e3ba9349b0a8bf2,
            limb1: 0x35134b2505cbb5a4c91f0ac4,
            limb2: 0x25e45206b13f43c4,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x8e97b007ffd9891bd0e77650,
            limb1: 0x77671278ac33f17df6b1db88,
            limb2: 0x243daddc47f5d5c2,
        },
        r0a1: u288 {
            limb0: 0x655fe4c8bbe5ee06aaa0054b,
            limb1: 0xf751450b02c93c7ddea95938,
            limb2: 0x21aa988e950d563f,
        },
        r1a0: u288 {
            limb0: 0xb51b3b6b8582de3eb0549518,
            limb1: 0x84a1031766b7e465f5bbf40c,
            limb2: 0xd46c2d5b95e5532,
        },
        r1a1: u288 {
            limb0: 0x50b6ddd8a5eef0067652191e,
            limb1: 0x298832a0bc46ebed8bff6190,
            limb2: 0xb568b4fe8311f93,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6eb18b18c49b1adc5ca4b6e5,
            limb1: 0x5aed44ad18aa014fbdecaf98,
            limb2: 0x2cfeabe29ec6bc30,
        },
        r0a1: u288 {
            limb0: 0x6021c59e332c537a44ba72bd,
            limb1: 0x2a6a2306cba0e9c6bc71ae94,
            limb2: 0x144672e2d2fd7efb,
        },
        r1a0: u288 {
            limb0: 0xbaaa764538282ad95d97f6f,
            limb1: 0xb45e898e62bbe2ec655c89d,
            limb2: 0x2ec14bb88be159b2,
        },
        r1a1: u288 {
            limb0: 0xbe248518e8d5fb0bc28a8c1d,
            limb1: 0xfbc2e6fece0da23463331f63,
            limb2: 0x23cb537b69c312c6,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x27d40df38e3ec413d0886a91,
            limb1: 0xba20895952c5cdf799770e53,
            limb2: 0x2876d953ce568b96,
        },
        r0a1: u288 {
            limb0: 0x2f418c4c5f7b265af15e8fa8,
            limb1: 0xf63d49e189f18cbee586e873,
            limb2: 0x102d998021961029,
        },
        r1a0: u288 {
            limb0: 0xd527d6756a5ff554d9ad87ef,
            limb1: 0x477150704fe1afb8610a511a,
            limb2: 0x22aaf38a411fdce9,
        },
        r1a1: u288 {
            limb0: 0x9cf471418eca7f059b6b31cd,
            limb1: 0x7f64ffd17f5480038ac1294a,
            limb2: 0x4fd8bd3c6df94ed,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xddb4db99db681d35f71a159c,
            limb1: 0xf71a330019414e6fdee75700,
            limb2: 0x14d9838e7d1918bb,
        },
        r0a1: u288 {
            limb0: 0x203c8bac71951a5f2c653710,
            limb1: 0x9fc93f8da38ecc2957313982,
            limb2: 0x7b6d981259cabd9,
        },
        r1a0: u288 {
            limb0: 0xa7297cdb5be0cc45d48ca6af,
            limb1: 0xa07b4b025ebe6c960eddfc56,
            limb2: 0xef2a5c30ef00652,
        },
        r1a1: u288 {
            limb0: 0xb7f05c76d860e9122b36ecd7,
            limb1: 0x407d6522e1f9ce2bcbf80eda,
            limb2: 0x197625a558f32c36,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1e814c56f7b55c93cee92de,
            limb1: 0xc53241d38daaf0fcb295de9f,
            limb2: 0x2686051ac61581b7,
        },
        r0a1: u288 {
            limb0: 0x4baaf054971a318a054c0096,
            limb1: 0x9c2edb804760a2aa61baeb9f,
            limb2: 0x25752015006f4a00,
        },
        r1a0: u288 {
            limb0: 0xe007ea41b2d4a0c66d585852,
            limb1: 0xcce4823b1d6701540c03a67a,
            limb2: 0x2a02613d3cff0e30,
        },
        r1a1: u288 {
            limb0: 0x70902af50e0b0c6fbdcf55df,
            limb1: 0xf242a8c001661109f3c60487,
            limb2: 0x2fb74d6456304b4f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb0f04df9dec94801e48a6ff7,
            limb1: 0xdc59d087c627d38334e5b969,
            limb2: 0x3d36e11420be053,
        },
        r0a1: u288 {
            limb0: 0xc80f070001aa1586189e0215,
            limb1: 0xff849fcbbbe7c00c83ab5282,
            limb2: 0x2a2354b2882706a6,
        },
        r1a0: u288 {
            limb0: 0x48cf70c80f08b6c7dc78adb2,
            limb1: 0xc6632efa77b36a4a1551d003,
            limb2: 0xc2d3533ece75879,
        },
        r1a1: u288 {
            limb0: 0x63e82ba26617416a0b76ddaa,
            limb1: 0xdaceb24adda5a049bed29a50,
            limb2: 0x1a82061a3344043b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x390888a6a4922c5c76754eb7,
            limb1: 0xa9c28c5ab479ee63c8cc433b,
            limb2: 0x12952fde47ad6043,
        },
        r0a1: u288 {
            limb0: 0x7403cd47019dc1f2bae1a2f7,
            limb1: 0x45ace85f2a2ac590ed57b732,
            limb2: 0x1733970e960aafe5,
        },
        r1a0: u288 {
            limb0: 0xf7a3bd5fdc5aaed5690514a6,
            limb1: 0xd0ba546be7da61a935aa8ad0,
            limb2: 0x266c6c791027e71,
        },
        r1a1: u288 {
            limb0: 0xecfc6da5bde095da954076c5,
            limb1: 0x7253cfcf8fc9900863486566,
            limb2: 0xafa50f568077d1b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9152fecf0f523415acc7c7be,
            limb1: 0xd9632cbfccc4ea5d7bf31177,
            limb2: 0x2d7288c5f8c83ab1,
        },
        r0a1: u288 {
            limb0: 0x53144bfe4030f3f9f5efda8,
            limb1: 0xfeec394fbf392b11c66bae27,
            limb2: 0x28840813ab8a200b,
        },
        r1a0: u288 {
            limb0: 0xdec3b11fbc28b305d9996ec7,
            limb1: 0x5b5f8d9d17199e149c9def6e,
            limb2: 0x10c1a149b6751bae,
        },
        r1a1: u288 {
            limb0: 0x665e8eb7e7d376a2d921c889,
            limb1: 0xfdd76d06e46ee1a943b8788d,
            limb2: 0x8bb21d9960e837b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3a67c28a175200e631aa506a,
            limb1: 0x7397303a34968ff17c06e801,
            limb2: 0x1b81e0c63123688b,
        },
        r0a1: u288 {
            limb0: 0x3490cfd4f076c621dac4a12c,
            limb1: 0xec183578c91b90b72e5887b7,
            limb2: 0x179fb354f608da00,
        },
        r1a0: u288 {
            limb0: 0x9322bde2044dde580a78ba33,
            limb1: 0xfc74821b668d3570cad38f8b,
            limb2: 0x8cec54a291f5e57,
        },
        r1a1: u288 {
            limb0: 0xc2818b6a9530ee85d4b2ae49,
            limb1: 0x8d7b651ad167f2a43d7a2d0a,
            limb2: 0x7c9ca9bab0ffc7f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xadc46d961470c08d705024b2,
            limb1: 0x7161aad8286db0b2eed2a82d,
            limb2: 0x1b210544d70f9604,
        },
        r0a1: u288 {
            limb0: 0x6c3189c702990ea6a297d945,
            limb1: 0xd4125f223d6eb914d2b2486,
            limb2: 0x17eab37855145f09,
        },
        r1a0: u288 {
            limb0: 0x4da969d57274ec80d27a2b56,
            limb1: 0x376f5f6bd09e2531df8f2d1e,
            limb2: 0xce7ebb695f41a44,
        },
        r1a1: u288 {
            limb0: 0x1d0fe0b3b47846a699854407,
            limb1: 0xae1c6bdf92c63268832ede,
            limb2: 0x921779e8f22ff52,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3e7cbe1cf29222b120f5875e,
            limb1: 0x4827f7f7ae5fe1b721e0f582,
            limb2: 0x293a046f534cba64,
        },
        r0a1: u288 {
            limb0: 0x3461038de3839c235a8bcd8d,
            limb1: 0xbd2d67cb39148a1a3d8a5d98,
            limb2: 0x1161cfa5b3424ce,
        },
        r1a0: u288 {
            limb0: 0xa2e2adb302f850ee79c8f0d8,
            limb1: 0xf379af89c5d1a83583ec2845,
            limb2: 0x14c11d08cb72e2bc,
        },
        r1a1: u288 {
            limb0: 0x72eb9d3b51ccc722d804541,
            limb1: 0x521fb980061dfa9a0bec2b58,
            limb2: 0x12d20c2eea6e33e0,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa576408f8300de3a7714e6ae,
            limb1: 0xe1072c9a16f202ecf37fbc34,
            limb2: 0x1b0cb1e2b5871263,
        },
        r0a1: u288 {
            limb0: 0x2128e2314694b663286e231e,
            limb1: 0x54bea71957426f002508f715,
            limb2: 0x36ecc5dbe069dca,
        },
        r1a0: u288 {
            limb0: 0x17c77cd88f9d5870957850ce,
            limb1: 0xb7f4ec2bc270ce30538fe9b8,
            limb2: 0x766279e588592bf,
        },
        r1a1: u288 {
            limb0: 0x1b6caddf18de2f30fa650122,
            limb1: 0x40b77237a29cada253c126c6,
            limb2: 0x74ff1349b1866c8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xedfe37b8b30020f0f58ec1ca,
            limb1: 0x48d834ccdee7908fe3e7beb7,
            limb2: 0x2ff1c4eab1070c55,
        },
        r0a1: u288 {
            limb0: 0x32cb21f2729fd6b48b0d016e,
            limb1: 0x8458791f31c9095a42fb214e,
            limb2: 0x8553ab092e88b51,
        },
        r1a0: u288 {
            limb0: 0x3139a21f8c55dfc2c05b61f9,
            limb1: 0xfc2de1d50be59b7e674c0166,
            limb2: 0x2d59eb87c0f8797f,
        },
        r1a1: u288 {
            limb0: 0x8160be25df09e1acf03a3298,
            limb1: 0x10940d5f4f71add33dd893b7,
            limb2: 0x18556617e2ea64aa,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3603266e05560becab36faef,
            limb1: 0x8c3b88c9390278873dd4b048,
            limb2: 0x24a715a5d9880f38,
        },
        r0a1: u288 {
            limb0: 0xe9f595b111cfd00d1dd28891,
            limb1: 0x75c6a392ab4a627f642303e1,
            limb2: 0x17b34a30def82ab6,
        },
        r1a0: u288 {
            limb0: 0xe706de8f35ac8372669fc8d3,
            limb1: 0x16cc7f4032b3f3ebcecd997d,
            limb2: 0x166eba592eb1fc78,
        },
        r1a1: u288 {
            limb0: 0x7d584f102b8e64dcbbd1be9,
            limb1: 0x2ead4092f009a9c0577f7d3,
            limb2: 0x2fe2c31ee6b1d41e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x72253d939632f8c28fb5763,
            limb1: 0x9b943ab13cad451aed1b08a2,
            limb2: 0xdb9b2068e450f10,
        },
        r0a1: u288 {
            limb0: 0x80f025dcbce32f6449fa7719,
            limb1: 0x8a0791d4d1ed60b86e4fe813,
            limb2: 0x1b1bd5dbce0ea966,
        },
        r1a0: u288 {
            limb0: 0xaa72a31de7d815ae717165d4,
            limb1: 0x501c29c7b6aebc4a1b44407f,
            limb2: 0x464aa89f8631b3a,
        },
        r1a1: u288 {
            limb0: 0x6b8d137e1ea43cd4b1f616b1,
            limb1: 0xdd526a510cc84f150cc4d55a,
            limb2: 0x1da2ed980ebd3f29,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x76f2bffbe7fada86b81f66d8,
            limb1: 0x1ca153dc9d8d76313a11e15c,
            limb2: 0x4dfe0d6ac80da25,
        },
        r0a1: u288 {
            limb0: 0x15de0056bf4d5ec08f31b585,
            limb1: 0x49dee87b56cf42482ea29947,
            limb2: 0x2dd6e5f7c369a3ed,
        },
        r1a0: u288 {
            limb0: 0x8724222ffd3b7cc98562a726,
            limb1: 0xd833734896649ce7bea0f4e4,
            limb2: 0x4bafcb255e9ffae,
        },
        r1a1: u288 {
            limb0: 0xc6abcd8cdf55ed71c4b6bf77,
            limb1: 0x7570ab21929ce47772b3fa62,
            limb2: 0xe52a936ff2bfd32,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2c2009cb218612209058ccbe,
            limb1: 0xb46a6e943d15091ef190f9e8,
            limb2: 0x2289c611719fb672,
        },
        r0a1: u288 {
            limb0: 0x2a9e201c061f76f9cfed13ae,
            limb1: 0x81677848ce175daf4f35ee5,
            limb2: 0x2acfbfcf958f1acb,
        },
        r1a0: u288 {
            limb0: 0xf348f08473dd2537773b13a2,
            limb1: 0x2b5e34cc2e8c38dea3cb3f7e,
            limb2: 0x1c491bc2a7adb20,
        },
        r1a1: u288 {
            limb0: 0xb16adeb6831a680bf92f96fd,
            limb1: 0x66c0dfec9008176ac6c05465,
            limb2: 0x15658ec6d4b3d7e2,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x867cced8a010850958f41ff5,
            limb1: 0x6a37fdb2b8993eed18bafe8e,
            limb2: 0x21b9f782109e5a7,
        },
        r0a1: u288 {
            limb0: 0x7307477d650618e66de38d0f,
            limb1: 0xacb622ce92a7e393dbe10ba1,
            limb2: 0x236e70838cee0ed5,
        },
        r1a0: u288 {
            limb0: 0xb564a308aaf5dda0f4af0f0d,
            limb1: 0x55fc71e2f13d8cb12bd51e74,
            limb2: 0x294cf115a234a9e9,
        },
        r1a1: u288 {
            limb0: 0xbd166057df55c135b87f35f3,
            limb1: 0xf9f29b6c50f1cce9b85ec9b,
            limb2: 0x2e8448d167f20f96,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x24bee441877d07b54f9d6a93,
            limb1: 0xb4b9dde52d06d7b2c90f16eb,
            limb2: 0xb994bd56ff5b92a,
        },
        r0a1: u288 {
            limb0: 0x3b8e26cc45d66e351484e019,
            limb1: 0x70f59ef7d28fef7dc0d8faa3,
            limb2: 0x125148c5abf3b005,
        },
        r1a0: u288 {
            limb0: 0xcc51a3e508588aede1697413,
            limb1: 0x753fc8fc14b43891570d1306,
            limb2: 0x195506e18f71c9fc,
        },
        r1a1: u288 {
            limb0: 0x3744792c156c77c09d234d37,
            limb1: 0x776a62e934910b01f3676baf,
            limb2: 0x2a42103be80992d6,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdedaff3205bb953b2c390b8a,
            limb1: 0xe1a899da21c1dafb485c707e,
            limb2: 0x1ec897e7a041493e,
        },
        r0a1: u288 {
            limb0: 0xf52c3c30cd4d3202b34089e0,
            limb1: 0xc652aa1ff533e1aad7532305,
            limb2: 0x2a1df766e5e3aa2e,
        },
        r1a0: u288 {
            limb0: 0x7ac695d3e19d79b234daaf3d,
            limb1: 0x5ce2f92666aec92a650feee1,
            limb2: 0x21ab4fe20d978e77,
        },
        r1a1: u288 {
            limb0: 0xa64a913a29a1aed4e0798664,
            limb1: 0x66bc208b511503d127ff5ede,
            limb2: 0x2389ba056de56a8d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe4efda9aecfba1e2061dd25a,
            limb1: 0x100ae9d6b9bef031a7189d47,
            limb2: 0xffda112d6aa6875,
        },
        r0a1: u288 {
            limb0: 0xc00ca5c70ae663b8ac3ff750,
            limb1: 0xa1469e7dda24c858475d4d8a,
            limb2: 0x8d2bfbde52295f1,
        },
        r1a0: u288 {
            limb0: 0x299abb24fd381da3733ab2b8,
            limb1: 0x98476e77bc8b4e329db566a8,
            limb2: 0x14bb023425192bb3,
        },
        r1a1: u288 {
            limb0: 0xf577ac449e28e468a72c16d3,
            limb1: 0x84db3bee09450fb711352d79,
            limb2: 0xda523cdc08ab80d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd88b16e68600a12e6c1f6006,
            limb1: 0x333243b43d3b7ff18d0cc671,
            limb2: 0x2b84b2a9b0f03ed8,
        },
        r0a1: u288 {
            limb0: 0xf3e2b57ddaac822c4da09991,
            limb1: 0xd7c894b3fe515296bb054d2f,
            limb2: 0x10a75e4c6dddb441,
        },
        r1a0: u288 {
            limb0: 0x73c65fbbb06a7b21b865ac56,
            limb1: 0x21f4ecd1403bb78729c7e99b,
            limb2: 0xaf88a160a6b35d4,
        },
        r1a1: u288 {
            limb0: 0xade61ce10b8492d659ff68d0,
            limb1: 0x1476e76cf3a8e0df086ad9eb,
            limb2: 0x2e28cfc65d61e946,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdf8b54b244108008e7f93350,
            limb1: 0x2ae9a68b9d6b96f392decd6b,
            limb2: 0x160b19eed152271c,
        },
        r0a1: u288 {
            limb0: 0xc18a8994cfbb2e8df446e449,
            limb1: 0x408d51e7e4adedd8f4f94d06,
            limb2: 0x27661b404fe90162,
        },
        r1a0: u288 {
            limb0: 0x1390b2a3b27f43f7ac73832c,
            limb1: 0x14d57301f6002fd328f2d64d,
            limb2: 0x17f3fa337367dddc,
        },
        r1a1: u288 {
            limb0: 0x79cab8ff5bf2f762c5372f80,
            limb1: 0xc979d6f385fae4b5e4785acf,
            limb2: 0x60c5307a735b00f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x31699ebd81054ad65be96504,
            limb1: 0xa246aab1cc8dc1bbbea38d44,
            limb2: 0x27965d8b9186310c,
        },
        r0a1: u288 {
            limb0: 0xf19bedb503281d7c6af9cb39,
            limb1: 0xfc657c2b2e8f3b0bc009b675,
            limb2: 0x27cf1314887fba45,
        },
        r1a0: u288 {
            limb0: 0x4c6ab9aa055461771d8e2357,
            limb1: 0x978e8adbefec12496f14ed3a,
            limb2: 0x94a5299580121ec,
        },
        r1a1: u288 {
            limb0: 0xeeed7578a72af394b2956631,
            limb1: 0xfa3e51714fab6b7b617ebb9b,
            limb2: 0x1568bc7686ecb652,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3abd1cc57be73d63539c7744,
            limb1: 0x5db601db3822cc797f353968,
            limb2: 0x26a41b3b0d6298c2,
        },
        r0a1: u288 {
            limb0: 0xc56b6b4f09d8bb0997d47760,
            limb1: 0xf97a3b1f59328086f51f3041,
            limb2: 0x13713579e59c08b1,
        },
        r1a0: u288 {
            limb0: 0x197f5114183900172f74b2ba,
            limb1: 0xe87f8ed64d4777fa49ee73f3,
            limb2: 0x1856a2b791ac99cb,
        },
        r1a1: u288 {
            limb0: 0x2eec98d5d150bf3f6a2c0bf,
            limb1: 0x43209949c0a87c01cebead6b,
            limb2: 0x21f7073995be0e75,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x386d7b23c6dccb87637018c9,
            limb1: 0xfed2ea478e9a2210289079e2,
            limb2: 0x100aa83cb843353e,
        },
        r0a1: u288 {
            limb0: 0x229c5c285f049d04c3dc5ce7,
            limb1: 0x28110670fe1d38c53ffcc6f7,
            limb2: 0x1778918279578f50,
        },
        r1a0: u288 {
            limb0: 0xe9ad2c7b8a17a1f1627ff09d,
            limb1: 0xedff5563c3c3e7d2dcc402ec,
            limb2: 0xa8bd6770b6d5aa8,
        },
        r1a1: u288 {
            limb0: 0x66c5c1aeed5c04470b4e8a3d,
            limb1: 0x846e73d11f2d18fe7e1e1aa2,
            limb2: 0x10a60eabe0ec3d78,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe73072b0d5c520b003d0c9d7,
            limb1: 0x2aa06bca20171f7240937f2f,
            limb2: 0x2f5fac6ec36bf08c,
        },
        r0a1: u288 {
            limb0: 0xaa7e4f6fc00c849f0b3b612c,
            limb1: 0x39d9ad4e48daaad0d07fe5e9,
            limb2: 0x25a315ad24037a5e,
        },
        r1a0: u288 {
            limb0: 0xa8994a15de0a1bdbd1764521,
            limb1: 0x81cf009919d7794cc4a7e6a,
            limb2: 0x1f75cfd887e667db,
        },
        r1a1: u288 {
            limb0: 0x8c7bc20891d704e3a0c26279,
            limb1: 0xbe88ca955d0b807a73bf84bc,
            limb2: 0x13a927e7019187b1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x88ca191d85be1f6c205257ef,
            limb1: 0xd0cecf5c5f80926c77fd4870,
            limb2: 0x16ec42b5cae83200,
        },
        r0a1: u288 {
            limb0: 0x154cba82460752b94916186d,
            limb1: 0x564f6bebac05a4f3fb1353ac,
            limb2: 0x2d47a47da836d1a7,
        },
        r1a0: u288 {
            limb0: 0xb39c4d6150bd64b4674f42ba,
            limb1: 0x93c967a38fe86f0779bf4163,
            limb2: 0x1a51995a49d50f26,
        },
        r1a1: u288 {
            limb0: 0xeb7bdec4b7e304bbb0450608,
            limb1: 0x11fc9a124b8c74b3d5560ea4,
            limb2: 0xbfa9bd7f55ad8ac,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x28dc30a40cfd4e3d16d569d7,
            limb1: 0xa7c3892e50298f844cb3e2da,
            limb2: 0x592b208860ef1a1,
        },
        r0a1: u288 {
            limb0: 0x43a18e2888edcfa55330e149,
            limb1: 0xe5566bf178036740f28c8982,
            limb2: 0x1bcd7fc056138257,
        },
        r1a0: u288 {
            limb0: 0x6c1f31538cbba5756c96f14a,
            limb1: 0x575350fe3de7d32c34494707,
            limb2: 0x18580884cdabb63e,
        },
        r1a1: u288 {
            limb0: 0x8a3bdd76258ec09877a498ca,
            limb1: 0x2dc9f6aba3804f81b28f5bf7,
            limb2: 0x1e1bb6bbc5fabfe5,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2fdc574c85cf0c0ce5e07a51,
            limb1: 0xd2439bf7b00bddc4cfb01b0c,
            limb2: 0x125c3bbdeb0bd2da,
        },
        r0a1: u288 {
            limb0: 0x9d664714bae53cafcb5ef55d,
            limb1: 0x495c01724790853548f5e4de,
            limb2: 0x2ce5e2e263725941,
        },
        r1a0: u288 {
            limb0: 0x98071eb7fe88c9124aee3774,
            limb1: 0xc3f66947a52bd2f6d520579f,
            limb2: 0x2eaf775dbd52f7d3,
        },
        r1a1: u288 {
            limb0: 0x23e5594948e21db2061dca92,
            limb1: 0xd0ffa6f6c77290531c185431,
            limb2: 0x604c085de03afb1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x602f2f5e2a33cf3baca2da2f,
            limb1: 0x91ee0aed77bbe8bff41180a6,
            limb2: 0x346902218e9c127,
        },
        r0a1: u288 {
            limb0: 0x186fbf050ed43018e85bcd72,
            limb1: 0xb26ad89604a3d314a0af6225,
            limb2: 0x19a7ccdd36ffd1ff,
        },
        r1a0: u288 {
            limb0: 0x8dc1c60415013218ebd6628,
            limb1: 0x3885e11f86f959eed42fa77,
            limb2: 0x25d5aa8e6412362b,
        },
        r1a1: u288 {
            limb0: 0x3075e0323bd8ee2c6e9d4ea9,
            limb1: 0x107adf07aff8236c610b530e,
            limb2: 0x1678e4ad714c195f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xeec2912e15f6bda39d4e005e,
            limb1: 0x2b8610c44d27bdbc6ba2aac5,
            limb2: 0x78ddc4573fc1fed,
        },
        r0a1: u288 {
            limb0: 0x48099a0da11ea21de015229d,
            limb1: 0x5fe937100967d5cc544f4af1,
            limb2: 0x2c9ffe6d7d7e9631,
        },
        r1a0: u288 {
            limb0: 0xa70d251296ef1ae37ceb7d03,
            limb1: 0x2adadcb7d219bb1580e6e9c,
            limb2: 0x180481a57f22fd03,
        },
        r1a1: u288 {
            limb0: 0xacf46db9631037dd933eb72a,
            limb1: 0x8a58491815c7656292a77d29,
            limb2: 0x261e3516c348ae12,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x64982655068f6e34fa5b974e,
            limb1: 0x7157deb99c07107031eeb577,
            limb2: 0x16c155e656423fd,
        },
        r0a1: u288 {
            limb0: 0xf5a454b991e05675894eaba1,
            limb1: 0x2f8e65e26bbefcc293f51ea1,
            limb2: 0x13ae017a42c89936,
        },
        r1a0: u288 {
            limb0: 0x5be675b63b9d6711fff16590,
            limb1: 0x24aca8b64fd32e2ccf1936a4,
            limb2: 0x1f33a5b5314466ae,
        },
        r1a1: u288 {
            limb0: 0x74b5b6bfcd5d3f5e7688ad89,
            limb1: 0xde9582f232f1cea7dd08cafb,
            limb2: 0x1ecf61f0f8c5eb5,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2bfa32f0a09c3e2cfb8f6a38,
            limb1: 0x7a24df3ff3c7119a59d49318,
            limb2: 0x10e42281d64907ba,
        },
        r0a1: u288 {
            limb0: 0xce42177a66cdeb4207d11e0c,
            limb1: 0x3322aa425a9ca270152372ad,
            limb2: 0x2f7fa83db407600c,
        },
        r1a0: u288 {
            limb0: 0x62a8ff94fd1c7b9035af4446,
            limb1: 0x3ad500601bbb6e7ed1301377,
            limb2: 0x254d253ca06928f,
        },
        r1a1: u288 {
            limb0: 0xf8f1787cd8e730c904b4386d,
            limb1: 0x7fd3744349918d62c42d24cc,
            limb2: 0x28a05e105d652eb8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6ef31e059d602897fa8e80a8,
            limb1: 0x66a0710847b6609ceda5140,
            limb2: 0x228c0e568f1eb9c0,
        },
        r0a1: u288 {
            limb0: 0x7b47b1b133c1297b45cdd79b,
            limb1: 0x6b4f04ed71b58dafd06b527b,
            limb2: 0x13ae6db5254df01a,
        },
        r1a0: u288 {
            limb0: 0xbeca2fccf7d0754dcf23ddda,
            limb1: 0xe3d0bcd7d9496d1e5afb0a59,
            limb2: 0x305a0afb142cf442,
        },
        r1a1: u288 {
            limb0: 0x2d299847431477c899560ecf,
            limb1: 0xbcd9e6c30bedee116b043d8d,
            limb2: 0x79473a2a7438353,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x411409ebfa38381a8a51b0d7,
            limb1: 0xf76b1505aa329dd385336e05,
            limb2: 0x2feeb798174213df,
        },
        r0a1: u288 {
            limb0: 0xb4c19447ac4c7f6651d3343c,
            limb1: 0x9907fb6004c577e27fa30b20,
            limb2: 0x1f27de53c890e63d,
        },
        r1a0: u288 {
            limb0: 0xe37c4250bb8953408d9f1569,
            limb1: 0xa91c7a0268ba1f0e9a7f061e,
            limb2: 0x28dad3d29d6fc341,
        },
        r1a1: u288 {
            limb0: 0x1461d0a8f9d5475a88da5ec1,
            limb1: 0x9bde3452acf5c601874718f3,
            limb2: 0x2015a1b9292b9387,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7b59cde94c964c508f0c580b,
            limb1: 0xb863a7e42c151cbcb273e48a,
            limb2: 0x12e28ebab6629a78,
        },
        r0a1: u288 {
            limb0: 0xfbbc65132e3294bcee5d9847,
            limb1: 0x49ce66f59e22f94bcb696d6b,
            limb2: 0x1acfef80ecc7de81,
        },
        r1a0: u288 {
            limb0: 0x8e19efec2a36a59826d0c67c,
            limb1: 0x4228514492b7d0d99a3858f6,
            limb2: 0xd2db299184693ca,
        },
        r1a1: u288 {
            limb0: 0x95fd78951b3a29938ca0969b,
            limb1: 0x3e6c45219ecd0f998cace562,
            limb2: 0x25c17897c2bf6ed,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x65b71fe695e7ccd4b460dace,
            limb1: 0xa6ceba62ef334e6fe91301d5,
            limb2: 0x299f578d0f3554e6,
        },
        r0a1: u288 {
            limb0: 0xaf781dd030a274e7ecf0cfa4,
            limb1: 0x2095020d373a14d7967797aa,
            limb2: 0x6a7f9df6f185bf8,
        },
        r1a0: u288 {
            limb0: 0x8e91e2dba67d130a0b274df3,
            limb1: 0xe192a19fce285c12c6770089,
            limb2: 0x6e9acf4205c2e22,
        },
        r1a1: u288 {
            limb0: 0xbcd5c206b5f9c77d667189bf,
            limb1: 0x656a7e2ebc78255d5242ca9,
            limb2: 0x25f43fec41d2b245,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3615feea5593872c721ce032,
            limb1: 0x9eb957c5e35bb008905baca6,
            limb2: 0x406f729508a6a01,
        },
        r0a1: u288 {
            limb0: 0x1752a08a84fda68975643ecd,
            limb1: 0xa7c7f3ba89297f6a7bb2146e,
            limb2: 0xdae8451b2ac8a25,
        },
        r1a0: u288 {
            limb0: 0x5b210ca5179ce523bf43e3c9,
            limb1: 0x5fb2351b9ea8c9781a58d0d7,
            limb2: 0x9c216964bdb9b2b,
        },
        r1a1: u288 {
            limb0: 0x17b0c201ceeae6d9d5164d5d,
            limb1: 0x7b49a7efec1e8f7b8accbf20,
            limb2: 0x75f0e28f0aa2bac,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4e56e6733cce20d9c5b16d96,
            limb1: 0xc7ef260535fb75b9d3e089f,
            limb2: 0x292dd4aa636e7729,
        },
        r0a1: u288 {
            limb0: 0x6e7e1038b336f36519c9faaf,
            limb1: 0x3c66bd609510309485e225c7,
            limb2: 0x10cacac137411eb,
        },
        r1a0: u288 {
            limb0: 0x4a3e8b96278ac092fe4f3b15,
            limb1: 0xba47e583e2750b42f93c9631,
            limb2: 0x125da6bd69495bb9,
        },
        r1a1: u288 {
            limb0: 0xae7a56ab4b959a5f6060d529,
            limb1: 0xc3c263bfd58c0030c063a48e,
            limb2: 0x2f4d15f13fae788c,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x301e0885c84d273b6d323124,
            limb1: 0x11fd5c75e269f7a30fa4154f,
            limb2: 0x19afdcfdcce2fc0d,
        },
        r0a1: u288 {
            limb0: 0x3d13519f934526be815c38b0,
            limb1: 0xd43735909547da73838874fc,
            limb2: 0x255d8aca30f4e0f6,
        },
        r1a0: u288 {
            limb0: 0x90a505b76f25a3396e2cea79,
            limb1: 0x3957a2d0848c54b9079fc114,
            limb2: 0x1ba0cd3a9fe6d4bb,
        },
        r1a1: u288 {
            limb0: 0xc47930fba77a46ebb1db30a9,
            limb1: 0x993a1cb166e9d40bebab02b2,
            limb2: 0x1deb16166d48118b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x71b57d6ac7d0d315211aa6da,
            limb1: 0xf867c0fca5b4a9f75ae9601,
            limb2: 0x2b918b64547ff1d9,
        },
        r0a1: u288 {
            limb0: 0x29643eb9aa339e1426afb6ad,
            limb1: 0x9f0122ad0ee7e5a8c9b217ea,
            limb2: 0x150a6fed3764baf1,
        },
        r1a0: u288 {
            limb0: 0xfff98d89e9073e4ff03b0a71,
            limb1: 0x2c95e5aeb62bea864fa1ce16,
            limb2: 0x169d2d66ee9c536f,
        },
        r1a1: u288 {
            limb0: 0x3b6c23294b65c06f0bfbc97e,
            limb1: 0x512ebd44049f934899c8c21f,
            limb2: 0xf3a422a521a7b65,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x699dd16639027e935625dae3,
            limb1: 0xce2fd75b31064d8c9543b09e,
            limb2: 0x2bf2e56d9f9aef33,
        },
        r0a1: u288 {
            limb0: 0xc7bc5b0e76d2d2cc5ebeef51,
            limb1: 0x751b560f6014ed921810d54c,
            limb2: 0xb94c3c617ec4cf6,
        },
        r1a0: u288 {
            limb0: 0x20952ae22896cdb44d45f80f,
            limb1: 0xce41430586d4dffcbe6d457d,
            limb2: 0x2e04e78247a0f706,
        },
        r1a1: u288 {
            limb0: 0xcbe0469e332a46e6c8d1fcc8,
            limb1: 0x91f3832bd6fd526ed0fd29ff,
            limb2: 0xc885453be2aaad8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb15bbaec50ff49d30e49f74a,
            limb1: 0xc90a8c79fb045c5468f14151,
            limb2: 0x25e47927e92df0e3,
        },
        r0a1: u288 {
            limb0: 0x57f66909d5d40dfb8c7b4d5c,
            limb1: 0xea5265282e2139c48c1953f2,
            limb2: 0x2d7f5e6aff2381f6,
        },
        r1a0: u288 {
            limb0: 0x2a2f573b189a3c8832231394,
            limb1: 0x738abc15844895ffd4733587,
            limb2: 0x20aa11739c4b9bb4,
        },
        r1a1: u288 {
            limb0: 0x51695ec614f1ff4cce2f65d1,
            limb1: 0x6765aae6cb895a2406a6dd7e,
            limb2: 0x1126ee431c522da0,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf4a153c7d86ed60951ab504,
            limb1: 0xf31e311b602435e1f66a4169,
            limb2: 0x2aea912bd2b272d,
        },
        r0a1: u288 {
            limb0: 0x962b2de6f2bb97c50e8135cd,
            limb1: 0x95b7329232682d8103a2bb0f,
            limb2: 0x2203e39b58e4f0fa,
        },
        r1a0: u288 {
            limb0: 0x360839724837e43137bec927,
            limb1: 0xd003651590a6d4842b430666,
            limb2: 0x24e28af92faa871b,
        },
        r1a1: u288 {
            limb0: 0x58a8973d95d0b9b27e08e9c5,
            limb1: 0xe9230b7a7561b2140f6fa0ed,
            limb2: 0x2470fab67e40c1ee,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9214fc3209f1518b05fd21c6,
            limb1: 0x9bc8ce4f56423009710770e8,
            limb2: 0x32445cc6972799c,
        },
        r0a1: u288 {
            limb0: 0x93ef401ecd9cfae3644d22e6,
            limb1: 0xce5a741a9847a144cfaf8c96,
            limb2: 0xf7a814d5726da4a,
        },
        r1a0: u288 {
            limb0: 0xd19264d986f163b133a91c0c,
            limb1: 0x529dc5ce4b193c0f672c6a32,
            limb2: 0x2e9a118959353374,
        },
        r1a1: u288 {
            limb0: 0x3d97d6e8f45072cc9e85e412,
            limb1: 0x4dafecb04c3bb23c374f0486,
            limb2: 0xa174dd4ac8ee628,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4705240ccec36ed1b06ec3bd,
            limb1: 0x7afed4d624f6be8dffffaf0f,
            limb2: 0x1eb3b1c78b56c80,
        },
        r0a1: u288 {
            limb0: 0xbb931ad8d3d66cfe13d42c74,
            limb1: 0x93ac592e0d6f4aea28088008,
            limb2: 0x25e3ddb8d54fc8dd,
        },
        r1a0: u288 {
            limb0: 0x67acc66859a4d375710acc08,
            limb1: 0xf22b0bd8af87c69684eb7ee3,
            limb2: 0x13aeef0bc76a5ddb,
        },
        r1a1: u288 {
            limb0: 0x19ff40829d75de5d1ea95a21,
            limb1: 0xe25cacd1120433c686708426,
            limb2: 0x2e1e97aa528af527,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x98d8b0c4adcf27bceb305c2c,
            limb1: 0x859afa9c7668ed6152d8cba3,
            limb2: 0x29e7694f46e3a272,
        },
        r0a1: u288 {
            limb0: 0x1d970845365594307ba97556,
            limb1: 0xd002d93ad793e154afe5b49b,
            limb2: 0x12ca77d3fb8eee63,
        },
        r1a0: u288 {
            limb0: 0x9f2934faefb8268e20d0e337,
            limb1: 0xbc4b5e1ec056881319f08766,
            limb2: 0x2e103461759a9ee4,
        },
        r1a1: u288 {
            limb0: 0x7adc6cb87d6b43000e2466b6,
            limb1: 0x65e5cefa42b25a7ee8925fa6,
            limb2: 0x2560115898d7362a,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd739fde836092ab29d99e015,
            limb1: 0x385159f1970eaec5d0df4062,
            limb2: 0x29c5a3b7c36b957b,
        },
        r0a1: u288 {
            limb0: 0xff4f1cc0beda0f1b6a41076,
            limb1: 0xf4748cece32e93e9d9113dd3,
            limb2: 0x10bde5c41a7fe3c0,
        },
        r1a0: u288 {
            limb0: 0xf22c545811997fa851b6579f,
            limb1: 0x19b083ce9d6c96778cf244,
            limb2: 0x2c30e438087a2084,
        },
        r1a1: u288 {
            limb0: 0x8acf2a9d6beba530d13bfafa,
            limb1: 0xd51656771ef36084386c4c14,
            limb2: 0x11029a7a333f82a9,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x64d864643668392c0e357cc4,
            limb1: 0x4c9bf66853f1b287015ab84c,
            limb2: 0x2f5f1b92ad7ee4d4,
        },
        r0a1: u288 {
            limb0: 0xdc33c8da5c575eef6987a0e1,
            limb1: 0x51cc07c7ef28e1b8d934bc32,
            limb2: 0x2358d94a17ec2a44,
        },
        r1a0: u288 {
            limb0: 0xf659845b829bbba363a2497b,
            limb1: 0x440f348e4e7bed1fb1eb47b2,
            limb2: 0x1ad0eaab0fb0bdab,
        },
        r1a1: u288 {
            limb0: 0x1944bb6901a1af6ea9afa6fc,
            limb1: 0x132319df135dedddf5baae67,
            limb2: 0x52598294643a4aa,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x76fd94c5e6f17fa6741bd7de,
            limb1: 0xc2e0831024f67d21013e0bdd,
            limb2: 0x21e2af6a43119665,
        },
        r0a1: u288 {
            limb0: 0xad290eab38c64c0d8b13879b,
            limb1: 0xdd67f881be32b09d9a6c76a0,
            limb2: 0x8000712ce0392f2,
        },
        r1a0: u288 {
            limb0: 0xd30a46f4ba2dee3c7ace0a37,
            limb1: 0x3914314f4ec56ff61e2c29e,
            limb2: 0x22ae1ba6cd84d822,
        },
        r1a1: u288 {
            limb0: 0x5d888a78f6dfce9e7544f142,
            limb1: 0x9439156de974d3fb6d6bda6e,
            limb2: 0x106c8f9a27d41a4f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9e228288b9d79abf0d678462,
            limb1: 0xfedb8701122c7b9a0096c39b,
            limb2: 0x1f11b6748ba590af,
        },
        r0a1: u288 {
            limb0: 0x217354cd5126bad2d4b626f3,
            limb1: 0xb7e1fc2c28f484147db9a209,
            limb2: 0x11cc96c980523c16,
        },
        r1a0: u288 {
            limb0: 0x67f1a6dea8dcb764052f2f30,
            limb1: 0xf61ef219e34841fdbf704437,
            limb2: 0x1b06ab371612d3c1,
        },
        r1a1: u288 {
            limb0: 0x95b395c036c24242528ac90f,
            limb1: 0xfca68405aa93f1e9c4902816,
            limb2: 0xa5001dc516a3b1b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcd828108ebb7618adf474f28,
            limb1: 0x7e35d9cfd1005ace6a7d673a,
            limb2: 0x1f0e9b7c0c9180d5,
        },
        r0a1: u288 {
            limb0: 0xf5772be41340ad007272dd47,
            limb1: 0xfefd1f1e5caf90b14be84f06,
            limb2: 0x5f5c60de55ee24a,
        },
        r1a0: u288 {
            limb0: 0x9f727cf085969f745fa66830,
            limb1: 0x19e3cc7dab959bcaa2d89bd8,
            limb2: 0x4e57fbad22ba576,
        },
        r1a1: u288 {
            limb0: 0xd13cfdf05607645e2e920453,
            limb1: 0x2d4612113c2e6237307c735d,
            limb2: 0x1dc8b92591a151a2,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x92c09e4796207b802168341b,
            limb1: 0xd2d9d6acffd7829066cc49ce,
            limb2: 0xc89c2d0a7b2c81e,
        },
        r0a1: u288 {
            limb0: 0x47e3c1cf6cdb6f3efe778c7f,
            limb1: 0x66b347099b6436794cf062eb,
            limb2: 0x18b4ccc64ae0a857,
        },
        r1a0: u288 {
            limb0: 0x7d5793606a73b2740c71484a,
            limb1: 0xa0070135ca2dc571b28e3c9c,
            limb2: 0x1bc03576e04b94cf,
        },
        r1a1: u288 {
            limb0: 0x1ba85b29875e638c10f16c99,
            limb1: 0x158f2f2acc3c2300bb9f9225,
            limb2: 0x42d8a8c36ea97c6,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9c5018b3f4543ccd212bb1e4,
            limb1: 0xdbc70cb1f46aedf8487561ce,
            limb2: 0x4cbe74c67b6540f,
        },
        r0a1: u288 {
            limb0: 0x9dae58abc82f3d5beb0e31a5,
            limb1: 0x2a418b283431d5341f060fed,
            limb2: 0x2bf4949a6a172e7f,
        },
        r1a0: u288 {
            limb0: 0xf1ec8ca327bc953b0c35b2a7,
            limb1: 0x522afd8c229845244f490bb3,
            limb2: 0x1b3c0a162c4acb6f,
        },
        r1a1: u288 {
            limb0: 0x38fcf4571e2a3985c1289c93,
            limb1: 0x87e81ab3ca0c0c8e4e7b5c90,
            limb2: 0x59e0938506a5153,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9440ad13408319cecb07087b,
            limb1: 0x537afc0c0cfe8ff761c24e08,
            limb2: 0x48e4ac10081048d,
        },
        r0a1: u288 {
            limb0: 0xa37fb82b03a2c0bb2aa50c4f,
            limb1: 0xd3797f05c8fb84f6b630dfb,
            limb2: 0x2dffde2d6c7e43ff,
        },
        r1a0: u288 {
            limb0: 0xc55d2eb1ea953275e780e65b,
            limb1: 0xe141cf680cab57483c02e4c7,
            limb2: 0x1b71395ce5ce20ae,
        },
        r1a1: u288 {
            limb0: 0xe4fab521f1212a1d301065de,
            limb1: 0x4f8d31c78df3dbe4ab721ef2,
            limb2: 0x2828f21554706a0e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x8cefc2f2af2a3082b790784e,
            limb1: 0x97ac13b37c6fbfc736a3d456,
            limb2: 0x683b1cdffd60acd,
        },
        r0a1: u288 {
            limb0: 0xa266a8188a8c933dcffe2d02,
            limb1: 0x18d3934c1838d7bce81b2eeb,
            limb2: 0x206ac5cdda42377,
        },
        r1a0: u288 {
            limb0: 0x90332652437f6e177dc3b28c,
            limb1: 0x75bd8199433d607735414ee8,
            limb2: 0x29d6842d8298cf7e,
        },
        r1a1: u288 {
            limb0: 0xadedf46d8ea11932db0018e1,
            limb1: 0xbc7239ae9d1453258037befb,
            limb2: 0x22e7ebdd72c6f7a1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x82c68ba644a50956043ecc8a,
            limb1: 0xc7d8a6b7a4a8df067507f696,
            limb2: 0x13e064f92a379629,
        },
        r0a1: u288 {
            limb0: 0x2e3102f909c832d510dac260,
            limb1: 0xdfbfc2a1c31c1bbab629d12a,
            limb2: 0x2e02cecf83d8df95,
        },
        r1a0: u288 {
            limb0: 0xa40a3fbee51a10a68d88f65d,
            limb1: 0x4b3dbab063a96108259eb85b,
            limb2: 0xec2a428037d7fd,
        },
        r1a1: u288 {
            limb0: 0xed4c7085b0c7f714626feeba,
            limb1: 0x76b3ad945eec7d599c9a61c9,
            limb2: 0x1d4a4e2bf33f788,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfd3ea10e061da248fc78c442,
            limb1: 0x3928568b7b75a3fadf637f7e,
            limb2: 0x16d8ef7db7db72d,
        },
        r0a1: u288 {
            limb0: 0xa691eb8ec65e9a05f9c37be,
            limb1: 0x46e164155611e68eb79d47b5,
            limb2: 0x149878ff630860de,
        },
        r1a0: u288 {
            limb0: 0xbf84f27793c5e80a3f5a6795,
            limb1: 0x265f41b966f78297141e4a0a,
            limb2: 0x26c1f9bf3a80e116,
        },
        r1a1: u288 {
            limb0: 0x9989c8e29a942b36c605ddcd,
            limb1: 0xaeac94367d026c3f4373ec4f,
            limb2: 0x1b005478a839f3b7,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x348e15357d9299e582033136,
            limb1: 0x53578c46b15abb39da35a56e,
            limb2: 0x1043b711f86bb33f,
        },
        r0a1: u288 {
            limb0: 0x9fa230a629b75217f0518e7c,
            limb1: 0x77012a4bb8751322a406024d,
            limb2: 0x121e2d845d972695,
        },
        r1a0: u288 {
            limb0: 0x5600f2d51f21d9dfac35eb10,
            limb1: 0x6fde61f876fb76611fb86c1a,
            limb2: 0x2bf4fbaf5bd0d0df,
        },
        r1a1: u288 {
            limb0: 0xd732aa0b6161aaffdae95324,
            limb1: 0xb3c4f8c3770402d245692464,
            limb2: 0x2a0f1740a293e6f0,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe36f967092d23437d70209f,
            limb1: 0x5a68614e46d18cb2a453eecf,
            limb2: 0x2540bdbce15de80e,
        },
        r0a1: u288 {
            limb0: 0xa1ab1dedb1cd20641354eab7,
            limb1: 0x3b41eab2d4c3f34aa3363d76,
            limb2: 0x29f5c565039e94d1,
        },
        r1a0: u288 {
            limb0: 0x8076f4cfbb1370bc68807184,
            limb1: 0xbfd5c762dbac12e54c97defd,
            limb2: 0x22dfdebdf80c8aef,
        },
        r1a1: u288 {
            limb0: 0xb73079fb3afe06fd5f10e0a6,
            limb1: 0x851cfc2aeb96701bfe1508c9,
            limb2: 0x2862a9abd52883a3,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa9e2efa41aaa98ab59728940,
            limb1: 0x163c0425f66ce72daef2f53e,
            limb2: 0x2feaf1b1770aa7d8,
        },
        r0a1: u288 {
            limb0: 0x3bb7afd3c0a79b6ac2c4c063,
            limb1: 0xee5cb42e8b2bc999e312e032,
            limb2: 0x1af2071ae77151c3,
        },
        r1a0: u288 {
            limb0: 0x1cef1c0d8956d7ceb2b162e7,
            limb1: 0x202b4af9e51edfc81a943ded,
            limb2: 0xc9e943ffbdcfdcb,
        },
        r1a1: u288 {
            limb0: 0xe18b1b34798b0a18d5ad43dd,
            limb1: 0x55e8237731941007099af6b8,
            limb2: 0x1472c0290db54042,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1d3ecfba1e0cbba59b220138,
            limb1: 0x6955bfd8db101a4edc130c4d,
            limb2: 0x18f732a6ce36814c,
        },
        r0a1: u288 {
            limb0: 0xc8e037c84e9c0565c8beb2ba,
            limb1: 0x52fcaeef7b5d0e60e8854f56,
            limb2: 0x1803c0332bb9e4a5,
        },
        r1a0: u288 {
            limb0: 0xd1b3ada31f2b77084b55b46,
            limb1: 0x30fa5d5269f73ec36c6959d1,
            limb2: 0x12f5d58c38cc8c80,
        },
        r1a1: u288 {
            limb0: 0x6e5379c6e563dc2721f5eb33,
            limb1: 0xc22083becff4ffd78da4c034,
            limb2: 0x8ed890289033e25,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb4c7963e0d1dc082de0725e,
            limb1: 0x375a7a3d765918de24804223,
            limb2: 0xf177b77b031596d,
        },
        r0a1: u288 {
            limb0: 0x87a7b9c5f10500b0b40d7a1e,
            limb1: 0x6f234d1dc7f1394b55858810,
            limb2: 0x26288146660a3914,
        },
        r1a0: u288 {
            limb0: 0xa6308c89cebe40447abf4a9a,
            limb1: 0x657f0fdda13b1f8ee314c22,
            limb2: 0x1701aabc250a9cc7,
        },
        r1a1: u288 {
            limb0: 0x9db9bf660dc77cbe2788a755,
            limb1: 0xbdf9c1c15a4bd502a119fb98,
            limb2: 0x14b4de3d26bd66e1,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x53c49c62ca96007e14435295,
            limb1: 0x85aeb885e4123ca8d3232fdf,
            limb2: 0x750017ce108abf3,
        },
        r0a1: u288 {
            limb0: 0xba6bf3e25d370182e4821239,
            limb1: 0x39de83bf370bd2ba116e8405,
            limb2: 0x2b8417a72ba6d940,
        },
        r1a0: u288 {
            limb0: 0xa922f50550d349849b14307b,
            limb1: 0x569766b6feca6143a5ddde9d,
            limb2: 0x2c3c6765b25a01d,
        },
        r1a1: u288 {
            limb0: 0x6016011bdc3b506563b0f117,
            limb1: 0xbab4932beab93dde9b5b8a5c,
            limb2: 0x1bf3f698de0ace60,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbf0c1251b02ea12bc02baa9f,
            limb1: 0x2194625fac4407c6c57a957a,
            limb2: 0x1c2c723c18f6bb5c,
        },
        r0a1: u288 {
            limb0: 0x7bf96abdccfbcc74a607e998,
            limb1: 0x290ad5e4bcf91939469006e0,
            limb2: 0xdf415ea3c6a9596,
        },
        r1a0: u288 {
            limb0: 0x2fe565c8e64fc7f1caeaceb7,
            limb1: 0x173b3284f8175cb72f8e288b,
            limb2: 0x13975609475133c,
        },
        r1a1: u288 {
            limb0: 0x315be9aff04ad6d539ca07f6,
            limb1: 0x69c85fec44425e7a9f6a27a4,
            limb2: 0x1808463caf69de30,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3b9f0412a593ef06cbf870ee,
            limb1: 0x787021117d0de0eb4e98b84e,
            limb2: 0x2665066b81a2157c,
        },
        r0a1: u288 {
            limb0: 0x44c0a88a37b444249e44e659,
            limb1: 0x7a7b32cbdd9e8fb04fc34095,
            limb2: 0x25fe3130e6af4859,
        },
        r1a0: u288 {
            limb0: 0xa32db39289509b232d6b6ae2,
            limb1: 0x1bb689faf497a3046af89e94,
            limb2: 0x7b3f0029c48d0df,
        },
        r1a1: u288 {
            limb0: 0x16ab43384aba95d9dee76ce3,
            limb1: 0xd5e5d14703eb32e066305692,
            limb2: 0x6b2a29e801e2fb4,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb9f05ffda3ee208f990ff3a8,
            limb1: 0x6201d08440b28ea672b9ea93,
            limb2: 0x1ed60e5a5e778b42,
        },
        r0a1: u288 {
            limb0: 0x8e8468b937854c9c00582d36,
            limb1: 0x7888fa8b2850a0c555adb743,
            limb2: 0xd1342bd01402f29,
        },
        r1a0: u288 {
            limb0: 0xf5c4c66a974d45ec754b3873,
            limb1: 0x34322544ed59f01c835dd28b,
            limb2: 0x10fe4487a871a419,
        },
        r1a1: u288 {
            limb0: 0xedf4af2df7c13d6340069716,
            limb1: 0x8592eea593ece446e8b2c83b,
            limb2: 0x12f9280ce8248724,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x660879ff917bf1fea6fa3484,
            limb1: 0xc8120509a524cd632b02941d,
            limb2: 0x3031a36c6c529ea4,
        },
        r0a1: u288 {
            limb0: 0x89b2473c307885cfc814cf91,
            limb1: 0x9ec1b9a889413383c62de3d4,
            limb2: 0xc5a9cf4a223da19,
        },
        r1a0: u288 {
            limb0: 0xb0d66de32c9ba438af34f925,
            limb1: 0x7371d7d317813570ac5f77c3,
            limb2: 0xb06f00c4a40fb06,
        },
        r1a1: u288 {
            limb0: 0x65e19cf808fbfd7482cb7fad,
            limb1: 0xdb191c4a1e552177a033c6c0,
            limb2: 0x1fbfbf3883cda5c8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe67f72c6d45f1bb04403139f,
            limb1: 0x9233e2a95d3f3c3ff2f7e5b8,
            limb2: 0x1f931e8e4343b028,
        },
        r0a1: u288 {
            limb0: 0x20ef53907af71803ce3ca5ca,
            limb1: 0xd99b6637ee9c73150b503ea4,
            limb2: 0x1c9759def8a98ea8,
        },
        r1a0: u288 {
            limb0: 0xa0a3b24c9089d224822fad53,
            limb1: 0xdfa2081342a7a895062f3e50,
            limb2: 0x185e8cf6b3e494e6,
        },
        r1a1: u288 {
            limb0: 0x8752a12394b29d0ba799e476,
            limb1: 0x1493421da067a42e7f3d0f8f,
            limb2: 0x67e7fa3e3035edf,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa36cae65800b4af8a8d9d177,
            limb1: 0x7b2cc4edebe180c0b5e48bb0,
            limb2: 0x1901f04b212ff183,
        },
        r0a1: u288 {
            limb0: 0x97feaa1bb822631cd24d4edb,
            limb1: 0x76b52a666be87c0a5efc6be7,
            limb2: 0x221b1e574f7a0d82,
        },
        r1a0: u288 {
            limb0: 0xaecaaef02d9a7ad21600cef8,
            limb1: 0x101d911a7c54797e924c5bea,
            limb2: 0x1482c0223aa888f,
        },
        r1a1: u288 {
            limb0: 0x6a187a14a2764b644b81b28a,
            limb1: 0xb8c3a31274c97c469a20ea73,
            limb2: 0xea85e747faf7429,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6d6138c95464e5e774ae7ba0,
            limb1: 0xe6ca73a5498e4ccd4bb68fc7,
            limb2: 0x15bf8aa8ed1beff6,
        },
        r0a1: u288 {
            limb0: 0xabd7c55a134ed405b4966d3c,
            limb1: 0xe69dd725ccc4f9dd537fe558,
            limb2: 0x2df4a03e2588a8f1,
        },
        r1a0: u288 {
            limb0: 0x7cf42890de0355ffc2480d46,
            limb1: 0xe33c2ad9627bcb4b028c2358,
            limb2: 0x2a18767b40de20bd,
        },
        r1a1: u288 {
            limb0: 0x79737d4a87fab560f3d811c6,
            limb1: 0xa88fee5629b91721f2ccdcf7,
            limb2: 0x2b51c831d3404d5e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x29bcbaef9121cfcfdf8789a2,
            limb1: 0x11b7009e410db7824f50798b,
            limb2: 0xf56b5dce599005,
        },
        r0a1: u288 {
            limb0: 0x57500ebcaf70ee66a8d854,
            limb1: 0x70b0bbdd6a86083da775d132,
            limb2: 0x1f0d34c88a0ee1e8,
        },
        r1a0: u288 {
            limb0: 0xff8240e731dc0217bfe7f17,
            limb1: 0x2f69c6d30de69761f873dba7,
            limb2: 0x25ef2aadbdcd7bb8,
        },
        r1a1: u288 {
            limb0: 0x6af873c60671428bf90f9404,
            limb1: 0x604cb4b70df42bdbec9c8670,
            limb2: 0x271660d8b2d4cc62,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9812f6145cf7e949fa207f20,
            limb1: 0x4061c36b08d5bcd408b14f19,
            limb2: 0x8332e08b2eb51ed,
        },
        r0a1: u288 {
            limb0: 0xa4a7ae8f65ba180c523cb33,
            limb1: 0xb71fabbdc78b1128712d32a5,
            limb2: 0x2acd1052fd0fefa7,
        },
        r1a0: u288 {
            limb0: 0x6ea5598e221f25bf27efc618,
            limb1: 0xa2c2521a6dd8f306f86d6db7,
            limb2: 0x13af144288655944,
        },
        r1a1: u288 {
            limb0: 0xea469c4b390716a6810fff5d,
            limb1: 0xf8052694d0fdd3f40b596c20,
            limb2: 0x24d0ea6c86e48c5c,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2e39be614d904bafea58a8cd,
            limb1: 0xf53f0a6a20a1f1783b0ea2d0,
            limb2: 0x99c451b7bb726d7,
        },
        r0a1: u288 {
            limb0: 0x28ec54a4ca8da838800c573d,
            limb1: 0xb78365fa47b5e192307b7b87,
            limb2: 0x2df87aa88e012fec,
        },
        r1a0: u288 {
            limb0: 0xfb7022881c6a6fdfb18de4aa,
            limb1: 0xb9bd30f0e93c5b93ad333bab,
            limb2: 0x1dd20cbccdeb9924,
        },
        r1a1: u288 {
            limb0: 0x16d8dfdf790a6be16a0e55ba,
            limb1: 0x90ab884395509b9a264472d4,
            limb2: 0xeaec571657b6e9d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf39692d8afe55bc3e4656a6f,
            limb1: 0xdaabb61fbbc638c24ddde47,
            limb2: 0x616dc3574e304c6,
        },
        r0a1: u288 {
            limb0: 0x4387670dce12e5bab8745497,
            limb1: 0xda03c2c0d2d2a0d84a68796c,
            limb2: 0x15dc8118b4406af8,
        },
        r1a0: u288 {
            limb0: 0xe0afb3f763ebc598d488d88,
            limb1: 0xb8d3cbd07df4b53632ecee7,
            limb2: 0x2d344d51df3522a2,
        },
        r1a1: u288 {
            limb0: 0x8d9ac84d7851eb4a88a14a5d,
            limb1: 0x91ebbf2130aa120e8e6fd9c2,
            limb2: 0xc69592e9b0dae8,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1feb082932799488f9e4428b,
            limb1: 0xd1684f2b0c8a780371e8240b,
            limb2: 0x183f917be56c1184,
        },
        r0a1: u288 {
            limb0: 0xcbce7c329c7f833d7c68e2b5,
            limb1: 0xbc9d361ee30e71f133e28d1f,
            limb2: 0x26cf7d7c3169f475,
        },
        r1a0: u288 {
            limb0: 0x9d8ebb1f32bfaf1866cb7af6,
            limb1: 0x9383d3682ceb781630bbfbdc,
            limb2: 0x192ed7795147e1ac,
        },
        r1a1: u288 {
            limb0: 0x59542369758454a79202b476,
            limb1: 0x1a2ff320911d05d8c71f5ddb,
            limb2: 0xab122d54e51086d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xce78fc6505db036c10fac771,
            limb1: 0x61f8c0bc7f60ad6415d5e419,
            limb2: 0x59009c5cf9ea663,
        },
        r0a1: u288 {
            limb0: 0xb3b3f697fc34d64ba053b914,
            limb1: 0x317af5815ce5bfffc5a6bc97,
            limb2: 0x23f97fee4deda847,
        },
        r1a0: u288 {
            limb0: 0xf559e09cf7a02674ac2fa642,
            limb1: 0x4fa7548b79cdd054e203689c,
            limb2: 0x2173b379d546fb47,
        },
        r1a1: u288 {
            limb0: 0x758feb5b51caccff9da0f78f,
            limb1: 0xd7f37a1008233b74c4894f55,
            limb2: 0x917c640b4b9627e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa798c009a427ce970785f209,
            limb1: 0x2ea8c4b64ae07a8c912ff700,
            limb2: 0xcf2e3bd3da3d6b1,
        },
        r0a1: u288 {
            limb0: 0x4e5666831ef8e127f34db951,
            limb1: 0x8f24b3d6d357c7f24caede84,
            limb2: 0x20089361beaa85ab,
        },
        r1a0: u288 {
            limb0: 0xde2658dd8c445721eab8635e,
            limb1: 0x6b1dc55a3abfc3a992b4b820,
            limb2: 0x221c6743bc4529fe,
        },
        r1a1: u288 {
            limb0: 0x4624f18e903efe0727ed96e4,
            limb1: 0x701059a78fa110c6587a2d20,
            limb2: 0x171adc817e942830,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x72548e0d946b796842cfecd8,
            limb1: 0x78b54b355e3c26476b0fab82,
            limb2: 0x2dc9f32c90b6ba31,
        },
        r0a1: u288 {
            limb0: 0xa943be83a6fc90414320753b,
            limb1: 0xd708fde97241095833ce5a08,
            limb2: 0x142111e6a73d2e82,
        },
        r1a0: u288 {
            limb0: 0xc79e8d5465ec5f28781e30a2,
            limb1: 0x697fb9430b9ad050ced6cce,
            limb2: 0x1a9d647149842c53,
        },
        r1a1: u288 {
            limb0: 0x9bab496952559362586725cd,
            limb1: 0xbe78e5a416d9665be64806de,
            limb2: 0x147b550afb4b8b84,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd40920213bc3bc96c9cf7680,
            limb1: 0x2912d147ef046e89bd357c72,
            limb2: 0xc3c9a2007960a4a,
        },
        r0a1: u288 {
            limb0: 0x23cbf0c5ff5921b45341c486,
            limb1: 0xea6a19b89a0031ff689bed22,
            limb2: 0x880e92536fbde5c,
        },
        r1a0: u288 {
            limb0: 0xa2122165e81bdf8b8ea43980,
            limb1: 0x9d90c397b8e8968a5073c40,
            limb2: 0x25777c0b869ec439,
        },
        r1a1: u288 {
            limb0: 0x65b87c8e5d3acb70ef35330e,
            limb1: 0xad8dbe5d2da49f5e81808b2e,
            limb2: 0x2ac6807f40704a89,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1422e11013fe6cdd7f843391,
            limb1: 0xfb96092ab69fc530e27d8d8e,
            limb2: 0xe39e04564fedd0,
        },
        r0a1: u288 {
            limb0: 0xbd4e81e3b4db192e11192788,
            limb1: 0x805257d3c2bdbc344a15ce0d,
            limb2: 0x10ddd4f47445106b,
        },
        r1a0: u288 {
            limb0: 0x87ab7f750b693ec75bce04e1,
            limb1: 0x128ba38ebed26d74d26e4d69,
            limb2: 0x2f1d22a64c983ab8,
        },
        r1a1: u288 {
            limb0: 0x74207c17f5c8335183649f77,
            limb1: 0x7144cd3520ac2e1be3204133,
            limb2: 0xb38d0645ab3499d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf0b44802374a599e5fd8d454,
            limb1: 0xbca9b89f095b26c8321ca9c0,
            limb2: 0x1e0bd624f3a168e1,
        },
        r0a1: u288 {
            limb0: 0x1d4eb4bf12580ed142cd1785,
            limb1: 0x901b367be0bd6a22b0ded573,
            limb2: 0x1f66547653d64f9,
        },
        r1a0: u288 {
            limb0: 0xad1285f40739f72c825f8b60,
            limb1: 0x761a391aa5ed7611f32f3c1c,
            limb2: 0x1f0b702d151a6d6a,
        },
        r1a1: u288 {
            limb0: 0x3c05bda93eadf285b1b1183,
            limb1: 0x92ab0a1e0e859527ebe010c0,
            limb2: 0x2b1c92ed714979d9,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x49173a889c697b0ab07f35bc,
            limb1: 0xdcffb65f4b4c21ced6b623af,
            limb2: 0x1366d12ee6022f7b,
        },
        r0a1: u288 {
            limb0: 0x285fdce362f7a79b89c49b5c,
            limb1: 0xae9358c8eaf26e2fed7353f5,
            limb2: 0x21c91fefaf522b5f,
        },
        r1a0: u288 {
            limb0: 0x748798f96436e3b18c64964a,
            limb1: 0xfc3bb221103d3966d0510599,
            limb2: 0x167859ae2ebc5e27,
        },
        r1a1: u288 {
            limb0: 0xe3b55b05bb30e23fa7eba05b,
            limb1: 0xa5fc8b7f7bc6abe91c90ddd5,
            limb2: 0xe0da83c6cdebb5a,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x30a4abff5957209783681bfb,
            limb1: 0x82d868d5ca421e4f1a0daf79,
            limb2: 0x1ba96ef98093d510,
        },
        r0a1: u288 {
            limb0: 0xd9132c7f206a6c036a39e432,
            limb1: 0x8a2dfb94aba29a87046110b8,
            limb2: 0x1fad2fd5e5e37395,
        },
        r1a0: u288 {
            limb0: 0x76b136dc82b82e411b2c44f6,
            limb1: 0xe405f12052823a54abb9ea95,
            limb2: 0xf125ba508c26ddc,
        },
        r1a1: u288 {
            limb0: 0x1bae07f5f0cc48e5f7aac169,
            limb1: 0x47d1288d741496a960e1a979,
            limb2: 0xa0911f6cc5eb84e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xca56045f126f666570cffb1c,
            limb1: 0x99dc890c5989a6c5cf307233,
            limb2: 0x1ff29a509f1043ce,
        },
        r0a1: u288 {
            limb0: 0xac5a551ac51ef0726b2a1a1e,
            limb1: 0xd21f2577f557bb4b5b8c70e2,
            limb2: 0x24dd34e1c5009bfd,
        },
        r1a0: u288 {
            limb0: 0xab066d42a5dd72732d2058f1,
            limb1: 0x69c0b7e40a7d7a9c4d5ea8,
            limb2: 0x58d486e640fe304,
        },
        r1a1: u288 {
            limb0: 0xbf9e282114df4d90fe6d5910,
            limb1: 0x66e50dd61b5dc7cea95ee1e3,
            limb2: 0x34eb679b30995af,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x69b06d504996c04114a6173c,
            limb1: 0xee92f03744c8f29ac115fdd4,
            limb2: 0x197b8306d7223355,
        },
        r0a1: u288 {
            limb0: 0x3322c134e4c733cf22ee4b70,
            limb1: 0x79e552ca3774fb411d916d65,
            limb2: 0x1b596b60e2a015c3,
        },
        r1a0: u288 {
            limb0: 0x3aa17d1fe7d9909dbc3ef783,
            limb1: 0xab4cdc6da4bc0f83f833150f,
            limb2: 0x151371363d1a6d31,
        },
        r1a1: u288 {
            limb0: 0xbfa21f08a86806c609857db5,
            limb1: 0x8df30ea45f2969bebf93dbef,
            limb2: 0x16f826274d71adab,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2e7b3a5a35456f42e87968e6,
            limb1: 0xb4303f5093c3a460674a2fcd,
            limb2: 0x2b5331f03b8fa15f,
        },
        r0a1: u288 {
            limb0: 0x7cea371d64d8bd0fc5b9427e,
            limb1: 0x76208e15fc175e352c274fbe,
            limb2: 0x5ceb46647d41234,
        },
        r1a0: u288 {
            limb0: 0x6cdac06bfcf041a30435a560,
            limb1: 0x15a7ab7ed1df6d7ed12616a6,
            limb2: 0x2520b0f462ad4724,
        },
        r1a1: u288 {
            limb0: 0xe8b65c5fff04e6a19310802f,
            limb1: 0xc96324a563d5dab3cd304c64,
            limb2: 0x230de25606159b1e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x23ac600fe3cd4842278c77f1,
            limb1: 0xe8ff2f43cd78cc8aee07d830,
            limb2: 0x957d9ada15e0971,
        },
        r0a1: u288 {
            limb0: 0xa7c223f25419ff013bffcfcf,
            limb1: 0x4197de0164fd2a664d053a3e,
            limb2: 0x22a5a5bc7d16b599,
        },
        r1a0: u288 {
            limb0: 0x99beb3fe225ffdaa443206f3,
            limb1: 0x59f1dc6e174b27e8e65b0a9f,
            limb2: 0x5a4d68ec236431,
        },
        r1a1: u288 {
            limb0: 0x762bbe45a41e58f22d55c0ee,
            limb1: 0x8e9d88f64e4ee8e27dafba38,
            limb2: 0x8480b67cfb4e81f,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb2236e5462d1e11842039bb5,
            limb1: 0x8d746dd0bb8bb2a455d505c1,
            limb2: 0x2fd3f4a905e027ce,
        },
        r0a1: u288 {
            limb0: 0x3d6d9836d71ddf8e3b741b09,
            limb1: 0x443f16e368feb4cb20a5a1ab,
            limb2: 0xb5f19dda13bdfad,
        },
        r1a0: u288 {
            limb0: 0x4e5612c2b64a1045a590a938,
            limb1: 0xbca215d075ce5769db2a29d7,
            limb2: 0x161e651ebdfb5065,
        },
        r1a1: u288 {
            limb0: 0xc02a55b6685351f24e4bf9c7,
            limb1: 0x4134240119050f22bc4991c8,
            limb2: 0x300bd9f8d76bbc11,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe9296a3a3aed4c4143d2e0ba,
            limb1: 0x7de973514b499b2da739b3e6,
            limb2: 0x1b4b807986fcdee0,
        },
        r0a1: u288 {
            limb0: 0xb9295fecce961afe0c5e6dad,
            limb1: 0xc4e30c322bcae6d526c4de95,
            limb2: 0x1fee592f513ed6b2,
        },
        r1a0: u288 {
            limb0: 0x7245f5e5e803d0d448fafe21,
            limb1: 0xcbdc032ecb3b7a63899c53d0,
            limb2: 0x1fde9ffc17accfc3,
        },
        r1a1: u288 {
            limb0: 0x8edcc1b2fdd35c87a7814a87,
            limb1: 0x99d54b5c2fe171c49aa9cb08,
            limb2: 0x130ef740e416a6fe,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1034982ab87008cff1938202,
            limb1: 0x3f3dcfb70aabfe28100af533,
            limb2: 0x1ff36dc352d057dd,
        },
        r0a1: u288 {
            limb0: 0x2cd3e72fb4c9c9d777afcd52,
            limb1: 0x25edb1c8cd7bfa5419f22065,
            limb2: 0x2d7e0ca9eeb89e4,
        },
        r1a0: u288 {
            limb0: 0x2e0dbbbeb0e2cc4fe41369f,
            limb1: 0xe87ad8f44156e610a3f47f60,
            limb2: 0x2449d548642e3d7d,
        },
        r1a1: u288 {
            limb0: 0x9584ecd113f9f18ad276287d,
            limb1: 0xfd21d9f88c5a9e304008423a,
            limb2: 0x27312295dc1dc39d,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc8b635efd8caeebdeeb5127c,
            limb1: 0xfe48f33349879a67a15018ad,
            limb2: 0x2ece1bbcd97e88bf,
        },
        r0a1: u288 {
            limb0: 0x4706cbd872893eee20fd3c9f,
            limb1: 0x505304c810682e3ad9d0a860,
            limb2: 0xa48ea35936c0821,
        },
        r1a0: u288 {
            limb0: 0x17429ea1c6e8442c3ddeb078,
            limb1: 0x96a0e8edcd10b0dde86b8957,
            limb2: 0x65ee3546bf98376,
        },
        r1a1: u288 {
            limb0: 0x43ed8af0f853a44a1676bd1b,
            limb1: 0x84aa6e279b2b88351f31f2f8,
            limb2: 0x63daa7a469d3c4e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x537ecf0916b38aeea21d4e47,
            limb1: 0x181a00de27ba4be1b380d6c8,
            limb2: 0x8c2fe2799316543,
        },
        r0a1: u288 {
            limb0: 0xe68fff5ee73364fff3fe403b,
            limb1: 0x7b8685c8a725ae79cfac8f99,
            limb2: 0x7b4be349766aba4,
        },
        r1a0: u288 {
            limb0: 0xdf7c93c0095545ad5e5361ea,
            limb1: 0xce316c76191f1e7cd7d03f3,
            limb2: 0x22ea21f18ddec947,
        },
        r1a1: u288 {
            limb0: 0xa19620b4c32db68cc1c2ef0c,
            limb1: 0xffa1e4be3bed5faba2ccbbf4,
            limb2: 0x16fc78a64c45f518,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2b6af476f520b4bf804415bc,
            limb1: 0xd949ee7f9e8874698b090fca,
            limb2: 0x34db5e5ec2180cf,
        },
        r0a1: u288 {
            limb0: 0x3e06a324f038ac8abcfb28d7,
            limb1: 0xc2e6375b7a83c0a0145f8942,
            limb2: 0x2247e79161483763,
        },
        r1a0: u288 {
            limb0: 0x708773d8ae3a13918382fb9d,
            limb1: 0xaf83f409556e32aa85ae92bf,
            limb2: 0x9af0a924ae43ba,
        },
        r1a1: u288 {
            limb0: 0xa6fded212ff5b2ce79755af7,
            limb1: 0x55a2adfb2699ef5de6581b21,
            limb2: 0x2476e83cfe8daa5c,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x65b3a2390f5daffda1495a18,
            limb1: 0x899088bd61beed2f86cf809c,
            limb2: 0xfd9eb567e23df18,
        },
        r0a1: u288 {
            limb0: 0x56b87a4fe158b918566526b2,
            limb1: 0x9528c7ccfd6734e5efef0864,
            limb2: 0x1a0fd3cd210ac66a,
        },
        r1a0: u288 {
            limb0: 0x7b29e07b5dba6defaa0b68d3,
            limb1: 0x31ab6b4d6d2b16095b169dde,
            limb2: 0x1fa8d6dab09be3e7,
        },
        r1a1: u288 {
            limb0: 0x1caeed71e8ba556cce2c0e7d,
            limb1: 0xe3670806bb1bdc273d5cf24a,
            limb2: 0x1ea4f9ef9e37289e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3e4c1ab89ffb3b8c239172e,
            limb1: 0xb2039058a7c490c1e3c45cf3,
            limb2: 0x25a02f05334c5953,
        },
        r0a1: u288 {
            limb0: 0x6cc45375d21dc205b4844c67,
            limb1: 0x197fde92cd9b39da7a8985a6,
            limb2: 0x26a7a0a701cbec02,
        },
        r1a0: u288 {
            limb0: 0x643fb9f1f431dcc9e961fbd1,
            limb1: 0xefa7d6c4327cebe96eed23ea,
            limb2: 0x2fce807b8b8fd044,
        },
        r1a1: u288 {
            limb0: 0xa0789513c3a5979954bbd255,
            limb1: 0x4b6bfcb206721aba078c99e7,
            limb2: 0x20791479dea42be6,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1c4759bcf7c607fe3f839d4d,
            limb1: 0xea91f311da73327e2ed40785,
            limb2: 0x2017052c72360f42,
        },
        r0a1: u288 {
            limb0: 0x38cf8a4368c0709980199fc3,
            limb1: 0xfc9047885996c19e84d7d4ea,
            limb2: 0x1795549eb0b97783,
        },
        r1a0: u288 {
            limb0: 0xb70f7ecfbec0eaf46845e8cc,
            limb1: 0x9ddf274c2a9f89ea3bc4d66f,
            limb2: 0xcc6f106abfcf377,
        },
        r1a1: u288 {
            limb0: 0xf6ff11ce29186237468c2698,
            limb1: 0x5c629ad27bb61e4826bb1313,
            limb2: 0x2014c6623f1fb55e,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdb5496bd3d342e8cbc9c87aa,
            limb1: 0xe30589d32f7a6c609d67180,
            limb2: 0x25cf7ce487f2fd1f,
        },
        r0a1: u288 {
            limb0: 0x7cf4d2d4120a1b1aab0043ef,
            limb1: 0x5167157815910ba1ad32e3b0,
            limb2: 0x25b9de319f00dd16,
        },
        r1a0: u288 {
            limb0: 0xa5b427b99debae0d616539ac,
            limb1: 0x98f358229107fe4d7eb8f17f,
            limb2: 0x2c54223a72576389,
        },
        r1a1: u288 {
            limb0: 0xb7b2af7bc0069a713244382,
            limb1: 0x832327ceb9b253c746b7da54,
            limb2: 0x2bba2fe8dab00fab,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc648054e4b6134bbfd68487f,
            limb1: 0xdf0506dad3f3d098c13a6386,
            limb2: 0x26bebeb6f46c2e8c,
        },
        r0a1: u288 {
            limb0: 0x9d0cdb28a94204776c6e6ba6,
            limb1: 0x303f02dfe619752b1607951d,
            limb2: 0x1127d8b17ef2c064,
        },
        r1a0: u288 {
            limb0: 0xe34ca1188b8db4e4694a696c,
            limb1: 0x243553602481d9b88ca1211,
            limb2: 0x1f8ef034831d0132,
        },
        r1a1: u288 {
            limb0: 0xe3a5dfb1785690dad89ad10c,
            limb1: 0xd690b583ace24ba033dd23e0,
            limb2: 0x405d0709e110c03,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6cd859c15ad12e6d3caf1256,
            limb1: 0x9799b747bdee89c0508b8445,
            limb2: 0x231291ac5f77196a,
        },
        r0a1: u288 {
            limb0: 0x59be066a22f4ef67983676bf,
            limb1: 0x60af3bde8316ffd3d914b862,
            limb2: 0xcb7503c9dcc6109,
        },
        r1a0: u288 {
            limb0: 0x43cda5e57739356196dbf9b3,
            limb1: 0x6d302e950403c26da5d29e0b,
            limb2: 0x3d88479e5d4476f,
        },
        r1a1: u288 {
            limb0: 0xa33efebae557cf6178cd757c,
            limb1: 0x9f6333d24bd87fa73f24a93c,
            limb2: 0xa24f7e64c5fac7b,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x72cc2cef2785ce4ff4e9b7af,
            limb1: 0x60ed5b9c207d7f31fb6234ab,
            limb2: 0x1bb17a4bc7b643ed,
        },
        r0a1: u288 {
            limb0: 0x9424eb15b502cde7927c7530,
            limb1: 0xa0e33edbbaa9de8e9c206059,
            limb2: 0x2b9a3a63bbf4af99,
        },
        r1a0: u288 {
            limb0: 0x423811cb6386e606cf274a3c,
            limb1: 0x8adcc0e471ecfe526f56dc39,
            limb2: 0x9169a8660d14368,
        },
        r1a1: u288 {
            limb0: 0xf616c863890c3c8e33127931,
            limb1: 0xcc9414078a6da6989dae6b91,
            limb2: 0x594d6a7e6b34ab2,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf9542e941e78ada2c0f15fe2,
            limb1: 0xf3420882f7da4f6b8e21a62a,
            limb2: 0x2636fc5f7608b33d,
        },
        r0a1: u288 {
            limb0: 0xb0857a89c798ffe78a3a5726,
            limb1: 0xd523c763b12bb980ad081297,
            limb2: 0x1ab1fd7473ea72a1,
        },
        r1a0: u288 {
            limb0: 0x1bcafa5b801308e4d54af163,
            limb1: 0x34650dbfef3c3778a2f72ce1,
            limb2: 0x24d47bedc194a4eb,
        },
        r1a1: u288 {
            limb0: 0x20979882cd41e55166a5c2af,
            limb1: 0x36761fc72ad75b97c32eeeba,
            limb2: 0x1ebccc398159d8c5,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf2d619ae78049bf9141c35cf,
            limb1: 0x717f8b10d469a1ee2d91f191,
            limb2: 0x2c72c82fa8afe345,
        },
        r0a1: u288 {
            limb0: 0xb89321223b82a2dc793c0185,
            limb1: 0x71506a0cf4adb8e51bb7b759,
            limb2: 0x2c13b92a98651492,
        },
        r1a0: u288 {
            limb0: 0x4947ef2c89276f77f9d20942,
            limb1: 0xb454d68685ab6b6976e71ec5,
            limb2: 0x19a938d0e78a3593,
        },
        r1a1: u288 {
            limb0: 0xbe883eb119609b489c01c905,
            limb1: 0xaa06779922047f52feac5ce6,
            limb2: 0x76977a3015dc164,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x43a96a588005043a46aadf2c,
            limb1: 0xa37b89d8a1784582f0c52126,
            limb2: 0x22e9ef3f5d4b2297,
        },
        r0a1: u288 {
            limb0: 0x8c6f6d8474cf6e5a58468a31,
            limb1: 0xeb1ce6ac75930ef1c79b07e5,
            limb2: 0xf49839a756c7230,
        },
        r1a0: u288 {
            limb0: 0x82b84693a656c8e8c1f962fd,
            limb1: 0x2c1c8918ae80282208b6b23d,
            limb2: 0x14d3504b5c8d428f,
        },
        r1a1: u288 {
            limb0: 0x60ef4f4324d5619b60a3bb84,
            limb1: 0x6d3090caefeedbc33638c77a,
            limb2: 0x159264c370c89fec,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1403c9b7840868a905ebc1d8,
            limb1: 0x19bd3253f2b1c80607dde8ce,
            limb2: 0x211d550502a3b3ca,
        },
        r0a1: u288 {
            limb0: 0x876ac65fa40ec9581bffbf72,
            limb1: 0xee0218b93f0524e758baeeb9,
            limb2: 0xfb25d107886145b,
        },
        r1a0: u288 {
            limb0: 0x1eb5e4cecec0abdb381e7678,
            limb1: 0xfa5478ff7b54d07c24062883,
            limb2: 0x258f88e931148fb4,
        },
        r1a1: u288 {
            limb0: 0x925223b66bb26f5a762b4aae,
            limb1: 0x8474ed1b86ebd538a21e12cb,
            limb2: 0x300fbbfd4e5d9d14,
        },
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xacef5f4f052cf33b719bf7b0,
            limb1: 0x29824295bb3f7dadd3fb4e66,
            limb2: 0x146ea3359f214153,
        },
        r0a1: u288 {
            limb0: 0x8e6406072cd9e60dcc61a9b8,
            limb1: 0xc2d94968e613563df5ccdbd3,
            limb2: 0x1c7443be6a09663e,
        },
        r1a0: u288 {
            limb0: 0x664b4bf9c0672bd136c63cf5,
            limb1: 0x7272787f6f05749ad601f87,
            limb2: 0xf073e2c9b475bc3,
        },
        r1a1: u288 {
            limb0: 0x28b73db1518881f0ba8866e9,
            limb1: 0x4f469cd67f96585ce26df391,
            limb2: 0xa70d1748fad1d0,
        },
    },
];

