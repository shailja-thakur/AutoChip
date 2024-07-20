module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] current_state, next_state;
    
    parameter B = 2'b00;
    parameter A = 2'b01;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B; // Asynchronously reset to state B
        end else begin
            current_state <= next_state;
        end
    end
    
    always @* begin
        case (current_state)
            B: begin
                if (in) begin
                    next_state = A; // Transition to state A if input is 1
                end else begin
                    next_state = B; // Stay in state B if input is 0
                end
            end
            
            A: begin
                if (in) begin
                    next_state = A; // Stay in state A if input is 1
                end else begin
                    next_state = B; // Transition to state B if input is 0
                end
            end

            default: next_state = B; // Default to state B if current state is invalid
        endcase
    end
    
    assign out = (current_state == A) ? 1'b1 : 1'b0; // Set output high if in state A, low otherwise
    
endmodule
