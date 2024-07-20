module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define state enumeration
typedef enum logic [1:0] {A, B} state_t;

// Define state register
reg state_t current_state, next_state;

// Define output register
reg out_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronously reset
        current_state <= B;
        out_reg <= 1'b0;
    end else begin
        // Sequentially update state
        current_state <= next_state;
        out_reg <= (next_state == A) ? 1'b1 : 1'b0;
    end
end

always @(current_state, in) begin
    case (current_state)
        A: begin
            // State A logic
            case (in)
                1'b0: next_state = B;
                1'b1: next_state = A;
            endcase
        end 
        B: begin
            // State B logic
            case (in)
                1'b0: next_state = A;
                1'b1: next_state = B;
            endcase
        end
    endcase
end

assign out = out_reg;

endmodule
