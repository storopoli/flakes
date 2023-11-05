{ config, pkgs, lib, ... }:

{
  home.file.".config/karabiner/karabiner.json" = ''
        {
        "global": {
            "ask_for_confirmation_before_quitting": true,
            "check_for_updates_on_startup": true,
            "show_in_menu_bar": false,
            "show_profile_name_in_menu_bar": false,
            "unsafe_ui": false
        },
        "profiles": [
            {
                "complex_modifications": {
                    "parameters": {
                        "basic.simultaneous_threshold_milliseconds": 50,
                        "basic.to_delayed_action_delay_milliseconds": 500,
                        "basic.to_if_alone_timeout_milliseconds": 500,
                        "basic.to_if_held_down_threshold_milliseconds": 500,
                        "mouse_motion_to_scroll.speed": 100
                    },
                    "rules": [
                        {
                            "description": "Change caps_lock to left_control if pressed with other keys, change caps_lock to escape if pressed alone.",
                            "manipulators": [
                                {
                                    "from": {
                                        "key_code": "caps_lock",
                                        "modifiers": {
                                            "optional": [
                                                "any"
                                            ]
                                        }
                                    },
                                    "to": [
                                        {
                                            "key_code": "left_control"
                                        }
                                    ],
                                    "to_if_alone": [
                                        {
                                            "key_code": "escape"
                                        }
                                    ],
                                    "type": "basic"
                                }
                            ]
                        }
                    ]
                },
                "devices": [
                    {
                        "disable_built_in_keyboard_if_exists": false,
                        "fn_function_keys": [],
                        "identifiers": {
                            "is_keyboard": true,
                            "is_pointing_device": false,
                            "product_id": 0,
                            "vendor_id": 0
                        },
                        "ignore": false,
                        "manipulate_caps_lock_led": true,
                        "simple_modifications": [],
                        "treat_as_built_in_keyboard": false
                    },
                    {
                        "disable_built_in_keyboard_if_exists": false,
                        "fn_function_keys": [],
                        "identifiers": {
                            "is_keyboard": false,
                            "is_pointing_device": true,
                            "product_id": 0,
                            "vendor_id": 0
                        },
                        "ignore": true,
                        "manipulate_caps_lock_led": false,
                        "simple_modifications": [],
                        "treat_as_built_in_keyboard": false
                    },
                    {
                        "disable_built_in_keyboard_if_exists": false,
                        "fn_function_keys": [],
                        "identifiers": {
                            "is_keyboard": true,
                            "is_pointing_device": false,
                            "product_id": 49295,
                            "vendor_id": 1133
                        },
                        "ignore": true,
                        "manipulate_caps_lock_led": true,
                        "simple_modifications": [],
                        "treat_as_built_in_keyboard": false
                    },
                    {
                        "disable_built_in_keyboard_if_exists": false,
                        "fn_function_keys": [],
                        "identifiers": {
                            "is_keyboard": false,
                            "is_pointing_device": true,
                            "product_id": 49295,
                            "vendor_id": 1133
                        },
                        "ignore": true,
                        "manipulate_caps_lock_led": false,
                        "simple_modifications": [],
                        "treat_as_built_in_keyboard": false
                    },
                    {
                        "disable_built_in_keyboard_if_exists": false,
                        "fn_function_keys": [],
                        "identifiers": {
                            "is_keyboard": true,
                            "is_pointing_device": false,
                            "product_id": 6505,
                            "vendor_id": 12951
                        },
                        "ignore": true,
                        "manipulate_caps_lock_led": true,
                        "simple_modifications": [],
                        "treat_as_built_in_keyboard": false
                    },
                    {
                        "disable_built_in_keyboard_if_exists": false,
                        "fn_function_keys": [],
                        "identifiers": {
                            "is_keyboard": false,
                            "is_pointing_device": true,
                            "product_id": 6505,
                            "vendor_id": 12951
                        },
                        "ignore": true,
                        "manipulate_caps_lock_led": false,
                        "simple_modifications": [],
                        "treat_as_built_in_keyboard": false
                    }
                ],
                "fn_function_keys": [
                    {
                        "from": {
                            "key_code": "f1"
                        },
                        "to": [
                            {
                                "consumer_key_code": "display_brightness_decrement"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f2"
                        },
                        "to": [
                            {
                                "consumer_key_code": "display_brightness_increment"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f3"
                        },
                        "to": [
                            {
                                "apple_vendor_keyboard_key_code": "mission_control"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f4"
                        },
                        "to": [
                            {
                                "apple_vendor_keyboard_key_code": "spotlight"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f5"
                        },
                        "to": [
                            {
                                "consumer_key_code": "dictation"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f6"
                        },
                        "to": [
                            {
                                "key_code": "f6"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f7"
                        },
                        "to": [
                            {
                                "consumer_key_code": "rewind"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f8"
                        },
                        "to": [
                            {
                                "consumer_key_code": "play_or_pause"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f9"
                        },
                        "to": [
                            {
                                "consumer_key_code": "fast_forward"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f10"
                        },
                        "to": [
                            {
                                "consumer_key_code": "mute"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f11"
                        },
                        "to": [
                            {
                                "consumer_key_code": "volume_decrement"
                            }
                        ]
                    },
                    {
                        "from": {
                            "key_code": "f12"
                        },
                        "to": [
                            {
                                "consumer_key_code": "volume_increment"
                            }
                        ]
                    }
                ],
                "name": "Default profile",
                "parameters": {
                    "delay_milliseconds_before_open_device": 1000
                },
                "selected": true,
                "simple_modifications": [],
                "virtual_hid_keyboard": {
                    "country_code": 0,
                    "indicate_sticky_modifier_keys_state": false,
                    "mouse_key_xy_scale": 100
                }
            }
        ]
    }
  '';
  home.file.".config/karabiner/assets/complex_modifications/1695928176.json".text = ''
    {
      "title": "Change caps_lock to dual keys, escape and left_control.",
      "rules": [
        {
          "description": "Change caps_lock to left_control if pressed with other keys, change caps_lock to escape if pressed alone.",
          "manipulators": [
            {
              "type": "basic",
              "from": {
                "key_code": "caps_lock",
                "modifiers": {
                  "optional": [
                    "any"
                  ]
                }
              },
              "to": [
                {
                  "key_code": "left_control"
                }
              ],
              "to_if_alone": [
                {
                  "key_code": "escape"
                }
              ]
            }
          ]
        }
      ]
    }  
  '';
}
