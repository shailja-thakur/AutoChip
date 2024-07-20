module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [3:0] state);

    // State register
    reg [3:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000; // B0
            shift_ena <= 1'b1;
        end else begin
            state <= next_state;
            shift_ena <= (state == 4'b0000 || state == 4'b0001 || state == 4'b0010 || state == 4'b0011);
        end
    end

    always @(state) begin
        case (state)
            4'b0000: next_state <= 4'b0001; // B0 to B1
            4'b0001: next_state <= 4'b0010; // B1 to B2
            4'b0010: next_state <= 4'b0011; // B2 to B3
            4'b0011: next_state <= 4'b0000; // B3 to Done
            default: next_state <= 4'b0011; // Default to Done
        endcase
    end

endmodule
