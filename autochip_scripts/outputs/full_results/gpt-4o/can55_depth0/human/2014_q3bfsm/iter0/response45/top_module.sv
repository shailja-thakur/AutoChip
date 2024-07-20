module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] y, Y;
    
    // State Encoding
    localparam S0 = 3'b000,
               S1 = 3'b001,
               S2 = 3'b010,
               S3 = 3'b011,
               S4 = 3'b100;
    
    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            y <= S0;
        else
            y <= Y;
    end

    // Next State Logic
    always @(*) begin
        case (y)
            S0: if (x) Y = S1; else Y = S0;
            S1: if (x) Y = S4; else Y = S1;
            S2: if (x) Y = S1; else Y = S2;
            S3: if (x) Y = S2; else Y = S1;
            S4: if (x) Y = S4; else Y = S3;
            default: Y = S0;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (y)
            S0: z = 0;
            S1: z = 0;
            S2: z = 0;
            S3: z = 1;
            S4: z = 1;
            default: z = 0;
        endcase
    end
endmodule
