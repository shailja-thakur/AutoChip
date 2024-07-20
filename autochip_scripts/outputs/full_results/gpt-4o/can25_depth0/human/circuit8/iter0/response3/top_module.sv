module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);
    // State variables
    reg [1:0] state;

    // State encoding
    localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    // Sequential process to update state and outputs
    always @(posedge clock) begin
        // State transitions
        case (state)
            S0: if (a) state <= S1; else state <= S0;
            S1: if (~a) state <= S2; else state <= S1;
            S2: if (a) state <= S3; else state <= S2;
            S3: if (~a) state <= S0; else state <= S3;
        endcase
    end

    // Outputs based on state
    always @(*) begin
        case (state)
            S0: begin p = 0; q = 0; end
            S1: begin p = 1; q = 0; end
            S2: begin p = 0; q = 1; end
            S3: begin p = 1; q = 1; end
            default: begin p = 0; q = 0; end
        endcase
    end

    // Initial state
    initial begin
        state = S0;
        p = 0;
        q = 0;
    end

endmodule
