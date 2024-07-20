module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State registers
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'd0;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        2'd0: // State A
            if (in == 0) begin
                next_state = 2'd0; // A
                out = 0;
            end
            else begin
                next_state = 2'd1; // B
                out = 0;
            end
        2'd1: // State B
            if (in == 0) begin
                next_state = 2'd2; // C
                out = 0;
            end
            else begin
                next_state = 2'd1; // B
                out = 0;
            end
        2'd2: // State C
            if (in == 0) begin
                next_state = 2'd0; // A
                out = 0;
            end
            else begin
                next_state = 2'd3; // D
                out = 0;
            end
        2'd3: // State D
            if (in == 0) begin
                next_state = 2'd2; // C
                out = 1;
            end
            else begin
                next_state = 2'd1; // B
                out = 1;
            end
        default:
            begin
                next_state = 2'd0; // A
                out = 0;
            end
    endcase
end

endmodule
