module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y; // current state
    
    // Define the state encoding
    parameter S0 = 3'b000, // state 000
              S1 = 3'b001, // state 001
              S2 = 3'b010, // state 010
              S3 = 3'b011, // state 011
              S4 = 3'b100; // state 100

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y <= S0; // synchronous reset to state 000
        end else begin
            case (y)
                S0: if (x) y <= S1; else y <= S0;
                S1: if (x) y <= S4; else y <= S1;
                S2: if (x) y <= S1; else y <= S2;
                S3: if (x) y <= S2; else y <= S1;
                S4: if (x) y <= S4; else y <= S3;
                default: y <= S0; // default state
            endcase
        end
    end

    always @(*) begin
        case (y)
            S0: z = 1'b0;
            S1: z = 1'b0;
            S2: z = 1'b0;
            S3: z = 1'b1;
            S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
endmodule
