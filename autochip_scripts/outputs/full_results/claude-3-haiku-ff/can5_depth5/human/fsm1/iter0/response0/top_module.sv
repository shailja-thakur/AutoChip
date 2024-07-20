module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // State variables
    reg current_state, next_state;
    
    // State definitions
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // Asynchronous reset
    always @(posedge areset) begin
        current_state <= B;
    end
    
    // State transition logic
    always @(current_state, in) begin
        case (current_state)
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            default: begin
                next_state = B;
            end
        endcase
    end
    
    // State update logic
    always @(posedge clk) begin
        current_state <= next_state;
    end
    
    // Output logic
    assign out = current_state;

endmodule
