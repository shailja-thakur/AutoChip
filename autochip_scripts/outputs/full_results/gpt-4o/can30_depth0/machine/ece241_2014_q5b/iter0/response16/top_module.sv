module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states using local parameters
    localparam A = 1'b0;
    localparam B = 1'b1;

    // State register
    reg state, next_state;

    // Sequential always block to update state on the posedge of clk or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Asynchronous reset to state A
        end else begin
            state <= next_state; // Update state
        end
    end

    // Combinational always block to determine next state and output
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1'b1; // Rising edge detected
                end else begin
                    next_state = A;
                    z = 1'b0;
                end
            end
            B: begin
                next_state = B;
                z = 1'b0; 
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule
