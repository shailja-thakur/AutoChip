module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Declare state encoding with one-hot encoding
    reg [1:0] state, next_state;
    
    // One-hot encoding for states
    parameter A = 2'b01;
    parameter B = 2'b10;

    // Sequential block for state transitions on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;  // Reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Combinational block to determine next state and output
    always @(*) begin
        // Default values
        next_state = state;
        z = 0;

        case (state)
            A: begin
                if (x == 1) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x == 1) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
        endcase
    end

endmodule
