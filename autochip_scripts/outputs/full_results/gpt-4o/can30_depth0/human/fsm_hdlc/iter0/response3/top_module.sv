module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    localparam S0 = 3'b000; // Initial state, behaving as though previous input were 0
    localparam S1 = 3'b001; // Saw 0
    localparam S2 = 3'b010; // Saw 01
    localparam S3 = 3'b011; // Saw 011
    localparam S4 = 3'b100; // Saw 0111
    localparam S5 = 3'b101; // Saw 01111
    localparam S6 = 3'b110; // Saw 011111
    localparam S7 = 3'b111; // Saw 0111111 (error if one more 1)

    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        // Default values for outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S0: if (in) next_state = S0; else next_state = S1;
            S1: if (in) next_state = S2; else next_state = S1;
            S2: if (in) next_state = S3; else next_state = S1;
            S3: if (in) next_state = S4; else next_state = S1;
            S4: if (in) next_state = S5; else next_state = S1;
            S5: if (in) next_state = S6; else next_state = S1;
            S6: if (in) next_state = S7; else begin next_state = S0; disc = 1; end
            S7: if (in) begin next_state = S7; err = 1; end else begin next_state = S0; flag = 1; end
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) state <= S0;
        else state <= next_state;
    end
endmodule
