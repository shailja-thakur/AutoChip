module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    reg [2:0] state, next_state;
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;
    
    // State transition and output logic
    always @(*) begin
        case (state)
            S0: begin
                z = 0;
                if (x) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                z = 0;
                if (x) next_state = S4;
                else next_state = S1;
            end
            S2: begin
                z = 0;
                if (x) next_state = S1;
                else next_state = S2;
            end
            S3: begin
                z = 1;
                if (x) next_state = S2;
                else next_state = S1;
            end
            S4: begin
                z = 1;
                if (x) next_state = S4;
                else next_state = S3;
            end
            default: begin
                z = 0;
                next_state = S0;
            end
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
