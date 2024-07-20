module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Define the two states of the state machine
    parameter A = 0;
    parameter B = 1;
    
    // Declare internal signals
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            state <= A;
        end else begin
            // Synchronous state transition
            case (state)
                A: begin
                    if (x) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    state <= B;
                end
                default: state <= A;
            endcase
        end
    end
    
    assign z = (state == A && x) || (state == B && !x);
    
endmodule
