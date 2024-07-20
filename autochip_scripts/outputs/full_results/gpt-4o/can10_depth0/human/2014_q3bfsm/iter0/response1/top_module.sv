module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y, y_next;

    // State encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    // State transition logic
    always @(*) begin
        case (y)
            S0: if (x == 1'b0) y_next = S0; else y_next = S1;
            S1: if (x == 1'b0) y_next = S1; else y_next = S4;
            S2: if (x == 1'b0) y_next = S2; else y_next = S1;
            S3: if (x == 1'b0) y_next = S1; else y_next = S2;
            S4: if (x == 1'b0) y_next = S3; else y_next = S4;
            default: y_next = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (y)
            S0, S1, S2: z = 1'b0;
            S3, S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            y <= S0;
        else
            y <= y_next;
    end

endmodule
