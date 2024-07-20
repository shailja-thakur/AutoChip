module top_module(
    input wire clk,
    input wire in,
    input wire areset,
    output wire out
);

reg [1:0] state, next_state;

// state machine
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // initialize state to B
    end else begin
        state <= next_state;
    end
end

// next state logic
always @* begin
    case (state)
        2'b00: // A
            if (in) begin
                next_state = 2'b00; // stay in A
            end else begin
                next_state = 2'b01; // transition to B
            end
        2'b01: // B
            if (in) begin
                next_state = 2'b01; // stay in B
            end else begin
                next_state = 2'b00; // transition to A
            end
        default:
            next_state = 2'b00;
    endcase
end

assign out = (state == 2'b01); // out is high when state is B, low otherwise

endmodule
