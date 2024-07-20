module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;
    
    // State register
    reg [2:0] state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset)
            state <= S0; // Synchronous reset
        else
            state <= next_state;
    end
    
    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            S0: begin
                if (x == 1) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
                z = 0;
            end
            S1: begin
                if (x == 1) begin
                    next_state = S4;
                end else begin
                    next_state = S1;
                end
                z = 0;
            end
            S2: begin
                if (x == 1) begin
                    next_state = S1;
                end else begin
                    next_state = S2;
                end
                z = 0;
            end
            S3: begin
                if (x == 1) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
                z = 1;
            end
            S4: begin
                if (x == 1) begin
                    next_state = S4;
                end else begin
                    next_state = S3;
                end
                z = 1;
            end
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end
endmodule
