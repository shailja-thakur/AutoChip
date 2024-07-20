module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        count <= 2'b00;
    end else begin
        case(state)
            2'b00: begin // State A
                if (s == 1)
                    state <= 2'b01; // State B
            end
            2'b01: begin // State B
                if (count == 2'b00 && w == 1) begin
                    count <= count + 1;
                end else if (count == 2'b01 && w == 1) begin
                    count <= count + 1;
                end else if (count == 2'b10 && w == 1) begin
                    count <= 2'b00;
                    state <= 2'b00; // Go back to State A
                    z <= 1;
                end else begin
                    count <= 2'b00;
                    state <= 2'b00; // Go back to State A
                    z <= 0;
                end
            end
        endcase
    end
end

endmodule
