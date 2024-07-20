module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg state;

always @(posedge clock) begin
  case (state)
    0: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 0;
      end else begin
        state <= 1;
      end
    end
    
    1: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 2;
      end else begin
        state <= 1;
      end
    end
    
    2: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 3;
      end else begin
        state <= 1;
      end
    end
    
    3: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 4;
      end else begin
        state <= 1;
      end
    end
    
    4: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 5;
      end else begin
        state <= 1;
      end
    end
    
    5: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 6;
      end else begin
        state <= 1;
      end
    end
    
    6: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 0;
      end else begin
        state <= 7;
      end
    end
    
    7: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 8;
      end else begin
        state <= 7;
      end
    end
    
    8: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 9;
      end else begin
        state <= 7;
      end
    end
    
    9: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 10;
      end else begin
        state <= 7;
      end
    end
    
    10: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 11;
      end else begin
        state <= 7;
      end
    end
    
    11: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 11;
      end else begin
        state <= 12;
      end
    end
    
    12: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 13;
      end else begin
        state <= 12;
      end
    end
    
    13: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 14;
      end else begin
        state <= 12;
      end
    end
    
    14: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 15;
      end else begin
        state <= 12;
      end
    end
    
    15: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 15;
      end else begin
        state <= 16;
      end
    end
    
    16: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 17;
      end else begin
        state <= 16;
      end
    end
    
    17: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 18;
      end else begin
        state <= 16;
      end
    end
    
    18: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 19;
      end else begin
        state <= 16;
      end
    end
    
    19: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 19;
      end else begin
        state <= 20;
      end
    end
    
    20: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 21;
      end else begin
        state <= 20;
      end
    end
    
    21: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 0;
      end else begin
        state <= 22;
      end
    end
    
    22: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 0;
      end else begin
        state <= 23;
      end
    end
    
    23: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 24;
      end else begin
        state <= 23;
      end
    end
    
    24: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 25;
      end else begin
        state <= 23;
      end
    end
    
    25: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 26;
      end else begin
        state <= 23;
      end
    end
    
    26: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 27;
      end else begin
        state <= 23;
      end
    end
    
    27: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 28;
      end else begin
        state <= 23;
      end
    end
    
    28: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 29;
      end else begin
        state <= 28;
      end
    end
    
    29: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 30;
      end else begin
        state <= 28;
      end
    end
    
    30: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 31;
      end else begin
        state <= 28;
      end
    end
    
    31: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 32;
      end else begin
        state <= 28;
      end
    end
    
    32: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 33;
      end else begin
        state <= 28;
      end
    end
    
    33: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 33;
      end else begin
        state <= 34;
      end
    end
    
    34: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 35;
      end else begin
        state <= 34;
      end
    end
    
    35: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 36;
      end else begin
        state <= 34;
      end
    end
    
    36: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 37;
      end else begin
        state <= 34;
      end
    end
    
    37: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 38;
      end else begin
        state <= 34;
      end
    end
    
    38: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 39;
      end else begin
        state <= 34;
      end
    end
    
    39: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 40;
      end else begin
        state <= 34;
      end
    end
    
    40: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 41;
      end else begin
        state <= 34;
      end
    end
    
    41: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 41;
      end else begin
        state <= 42;
      end
    end
    
    42: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 43;
      end else begin
        state <= 42;
      end
    end
    
    43: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 44;
      end else begin
        state <= 42;
      end
    end
    
    44: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 45;
      end else begin
        state <= 42;
      end
    end
    
    45: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 45;
      end else begin
        state <= 46;
      end
    end
    
    46: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 47;
      end else begin
        state <= 46;
      end
    end
    
    47: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 48;
      end else begin
        state <= 46;
      end
    end
    
    48: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 49;
      end else begin
        state <= 46;
      end
    end
    
    49: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 49;
      end else begin
        state <= 50;
      end
    end
    
    50: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 51;
      end else begin
        state <= 50;
      end
    end
    
    51: begin
      p <= 1;
      q <= 1;
      if (a == 0) begin
        state <= 52;
      end else begin
        state <= 51;
      end
    end
    
    52: begin
      p <= 1;
      q <= 1;
      if (a == 0) begin
        state <= 53;
      end else begin
        state <= 51;
      end
    end
    
    53: begin
      p <= 1;
      q <= 1;
      if (a == 0) begin
        state <= 54;
      end else begin
        state <= 51;
      end
    end
    
    54: begin
      p <= 1;
      q <= 1;
      if (a == 0) begin
        state <= 55;
      end else begin
        state <= 51;
      end
    end
    
    55: begin
      p <= 1;
      q <= 1;
      if (a == 0) begin
        state <= 56;
      end else begin
        state <= 51;
      end
    end
    
    56: begin
      p <= 1;
      q <= 1;
      if (a == 0) begin
        state <= 57;
      end else begin
        state <= 51;
      end
    end
    
    57: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 58;
      end else begin
        state <= 57;
      end
    end
    
    58: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 59;
      end else begin
        state <= 57;
      end
    end
    
    59: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 60;
      end else begin
        state <= 57;
      end
    end
    
    60: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 61;
      end else begin
        state <= 57;
      end
    end
    
    61: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 62;
      end else begin
        state <= 57;
      end
    end
    
    62: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 62;
      end else begin
        state <= 63;
      end
    end
    
    63: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 64;
      end else begin
        state <= 63;
      end
    end
    
    64: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 65;
      end else begin
        state <= 63;
      end
    end
    
    65: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 66;
      end else begin
        state <= 63;
      end
    end
    
    66: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 67;
      end else begin
        state <= 63;
      end
    end
    
    67: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 68;
      end else begin
        state <= 63;
      end
    end
    
    68: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 69;
      end else begin
        state <= 63;
      end
    end
    
    69: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 70;
      end else begin
        state <= 63;
      end
    end
    
    70: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 71;
      end else begin
        state <= 63;
      end
    end
    
    71: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 72;
      end else begin
        state <= 63;
      end
    end
    
    72: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 73;
      end else begin
        state <= 63;
      end
    end
    
    73: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 74;
      end else begin
        state <= 63;
      end
    end
    
    74: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 75;
      end else begin
        state <= 74;
      end
    end
    
    75: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 76;
      end else begin
        state <= 74;
      end
    end
    
    76: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 77;
      end else begin
        state <= 74;
      end
    end
    
    77: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 78;
      end else begin
        state <= 74;
      end
    end
    
    78: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 79;
      end else begin
        state <= 74;
      end
    end
    
    79: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 79;
      end else begin
        state <= 80;
      end
    end
    
    80: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 81;
      end else begin
        state <= 80;
      end
    end
    
    81: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 82;
      end else begin
        state <= 81;
      end
    end
    
    82: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 83;
      end else begin
        state <= 81;
      end
    end
    
    83: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 84;
      end else begin
        state <= 81;
      end
    end
    
    84: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 85;
      end else begin
        state <= 81;
      end
    end
    
    85: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 86;
      end else begin
        state <= 81;
      end
    end
    
    86: begin
      p <= 1;
      q <= 0;
      if (a == 0) begin
        state <= 87;
      end else begin
        state <= 81;
      end
    end
    
    87: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 0;
      end else begin
        state <= 88;
      end
    end
    
    88: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 89;
      end else begin
        state <= 88;
      end
    end
    
    89: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 90;
      end else begin
        state <= 88;
      end
    end
    
    90: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 91;
      end else begin
        state <= 88;
      end
    end
    
    91: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 92;
      end else begin
        state <= 88;
      end
    end
    
    92: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 92;
      end else begin
        state <= 93;
      end
    end
    
    93: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 94;
      end else begin
        state <= 93;
      end
    end
    
    94: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 95;
      end else begin
        state <= 93;
      end
    end
    
    95: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 96;
      end else begin
        state <= 93;
      end
    end
    
    96: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 97;
      end else begin
        state <= 93;
      end
    end
    
    97: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 98;
      end else begin
        state <= 93;
      end
    end
    
    98: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 99;
      end else begin
        state <= 93;
      end
    end
    
    99: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 100;
      end else begin
        state <= 93;
      end
    end
    
    100: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 101;
      end else begin
        state <= 93;
      end
    end
    
    101: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 102;
      end else begin
        state <= 93;
      end
    end
    
    102: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 103;
      end else begin
        state <= 93;
      end
    end
    
    103: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 104;
      end else begin
        state <= 93;
      end
    end
    
    104: begin
      p <= 0;
      q <= 1;
      if (a == 0) begin
        state <= 105;
      end else begin
        state <= 93;
      end
    end
    
    105: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 0;
      end else begin
        state <= 106;
      end
    end
    
    106: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 107;
      end else begin
        state <= 106;
      end
    end
    
    107: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 108;
      end else begin
        state <= 106;
      end
    end
    
    108: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 109;
      end else begin
        state <= 106;
      end
    end
    
    109: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 110;
      end else begin
        state <= 106;
      end
    end
    
    110: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 110;
      end else begin
        state <= 111;
      end
    end
    
    111: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 112;
      end else begin
        state <= 111;
      end
    end
    
    112: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 113;
      end else begin
        state <= 111;
      end
    end
    
    113: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 114;
      end else begin
        state <= 111;
      end
    end
    
    114: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 115;
      end else begin
        state <= 111;
      end
    end
    
    115: begin
      p <= 0;
      q <= 0;
      if (a == 0) begin
        state <= 115;
      end else begin
        state <= 0;
      end
    end
    
    default: state <= 0;
  endcase
end

endmodule
