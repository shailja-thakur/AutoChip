module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case(state)
        0: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 1;
            end
        end
        
        1: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 2;
            end
        end
        
        2: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 3;
            end
        end
        
        3: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 4;
            end
        end
        
        4: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 5;
            end
        end
        
        5: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 6;
            end
        end
        
        6: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 7;
            end
        end
        
        7: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 8;
            end
        end
        
        8: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 9;
            end
        end
        
        9: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 10;
            end
        end
        
        10: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 11;
            end
        end
        
        11: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 12;
            end
        end
        
        12: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 13;
            end
        end
        
        13: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 14;
            end
        end
        
        14: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 15;
            end
        end
        
        15: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 16;
            end
        end
        
        16: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 17;
            end
        end
        
        17: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 18;
            end
        end
        
        18: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 19;
            end
        end
        
        19: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 20;
            end
        end
        
        20: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 21;
            end
        end
        
        21: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 22;
            end
        end
        
        22: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 23;
            end
        end
        
        23: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 24;
            end
        end
        
        24: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 25;
            end
        end
        
        25: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 26;
            end
        end
        
        26: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 27;
            end
        end
        
        27: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 28;
            end
        end
        
        28: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 29;
            end
        end
        
        29: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 30;
            end
        end
        
        30: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 31;
            end
        end
        
        31: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 32;
            end
        end
        
        32: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 33;
            end
        end
        
        33: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 34;
            end
        end
        
        34: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 35;
            end
        end
        
        35: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 36;
            end
        end
        
        36: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 37;
            end
        end
        
        37: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 38;
            end
        end
        
        38: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 39;
            end
        end
        
        39: begin
            if (a) begin
                p <= 0;
                q <= 1;
                state <= 40;
            end
        end
        
        40: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 41;
            end
        end
        
        41: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 42;
            end
        end
        
        42: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 43;
            end
        end
        
        43: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 44;
            end
        end
        
        44: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 45;
            end
        end
        
        45: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 46;
            end
        end
        
        46: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 47;
            end
        end
        
        47: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 48;
            end
        end
        
        48: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 49;
            end
        end
        
        49: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 50;
            end
        end
        
        50: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 51;
            end
        end
        
        51: begin
            if (a) begin
                p <= 0;
                q <= 0;
                state <= 52;
            end
        end
        
        52: begin
            if (a) begin
                p <= 1;
                q <= 1;
                state <= 0;
            end
        end
    endcase
end

endmodule
