module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define the states using local parameters
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    // Declare registers for the current state and next state
    reg [2:0] current_state;
    reg [2:0] next_state;
    
    // Output z is high when the state machine is in state E or F
    assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
    
    // Clock-triggered always block
    always @(posedge clk) begin
        // Reset the state machine if reset signal is high
        if (reset) begin
            current_state <= A;
        end else begin
            // Transition to the next state based on the current state and input w
            case (current_state)
                A: begin
                    if (w) begin
                        next_state <= A;
                    end else begin
                        next_state <= B;
                    end
                end
                B: begin
                    if (w) begin
                        next_state <= D;
                    end else begin
                        next_state <= C;
                    end
                end
                C: begin
                    if (w) begin
                        next_state <= D;
                    end else begin
                        next_state <= E;
                    end
                end
                D: begin
                    if (w) begin
                        next_state <= A;
                    end else begin
                        next_state <= F;
                    end
                end
                E: begin
                    if (w) begin
                        next_state <= D;
                    end else begin
                        next_state <= E;
                    end
                end
                F: begin
                    if (w) begin
                        next_state <= D;
                    end else begin
                        next_state <= C;
                    end
                end
                default: begin
                    next_state <= A;
                end
            endcase
        end
    end
    
    // Assign the next state to the current state at every positive edge of clk
    always @(posedge clk) begin
        current_state <= next_state;
    end

endmodule
