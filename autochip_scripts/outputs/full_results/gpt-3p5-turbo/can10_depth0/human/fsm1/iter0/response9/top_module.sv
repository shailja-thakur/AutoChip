module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// State enumeration
typedef enum logic [1:0] {
    B,
    A
} state_t;

// Declare state and next state variables
reg state_t current_state, next_state;

// Declare output variable
reg out;

// Moore machine logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= B;
    end else begin
        current_state <= next_state;
    end
end

always @(current_state or in) begin
    case (current_state)
        B: begin
            out <= 1'b1;
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= A;
            end
        end
        A: begin
            out <= 1'b0;
            if (in) begin
                next_state <= A;
            end else begin
                next_state <= B;
            end
        end
    endcase
end

endmodule
