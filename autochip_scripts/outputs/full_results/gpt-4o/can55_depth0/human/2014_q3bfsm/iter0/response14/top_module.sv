module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] y; // State register

    // State definitions
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    always @(posedge clk) begin
        if (reset) begin
            y <= S0; // Synchronous reset
        end else begin
            case (y)
                S0: y <= x ? S1 : S0;
                S1: y <= x ? S4 : S1;
                S2: y <= x ? S1 : S2;
                S3: y <= x ? S2 : S1;
                S4: y <= x ? S4 : S3;
                default: y <= S0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            z <= 0; // Reset output
        end else begin
            case (y)
                S3, S4: z <= 1;
                default: z <= 0;
            endcase
        end
    end

endmodule
