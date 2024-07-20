module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @ (*) begin
    case ({c, d})
        // When c=0 and d=0
        2'b00: begin
            case ({a, b})
                // When a=0 and b=0
                2'b00: out = 1;
                // When a=0 and b=1
                2'b01: out = 0;
                // When a=1 and b=0
                2'b10: out = 0;
                // When a=1 and b=1
                2'b11: out = 1;
            endcase
        end
        // When c=0 and d=1
        2'b01: begin
            case ({a, b})
                // When a=0 and b=0
                2'b00: out = 1;
                // When a=0 and b=1
                2'b01: out = 0;
                // When a=1 and b=0
                2'b10: out = d;
                // When a=1 and b=1
                2'b11: out = d;
            endcase
        end
        // When c=1 and d=0
        2'b10: begin
            case ({a, b})
                // When a=0 and b=0
                2'b00: out = d;
                // When a=0 and b=1
                2'b01: out = d;
                // When a=1 and b=0
                2'b10: out = 1;
                // When a=1 and b=1
                2'b11: out = 1;
            endcase
        end
        // When c=1 and d=1
        2'b11: begin
            case ({a, b})
                // When a=0 and b=0
                2'b00: out = 0;
                // When a=0 and b=1
                2'b01: out = d;
                // When a=1 and b=0
                2'b10: out = 0;
                // When a=1 and b=1
                2'b11: out = 1;
            endcase
        end
    endcase
end

endmodule
