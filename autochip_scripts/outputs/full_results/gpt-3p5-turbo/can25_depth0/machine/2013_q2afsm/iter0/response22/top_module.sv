module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00; // Set state to A
    else
        state <= next; // Update state based on next state
end

always @* begin
    case (state)
        2'b00: begin // State A
            if (r[0]) next = 2'b01; // Next state is B if r[0] is high
            else if (r[1]) next = 2'b10; // Next state is C if r[1] is high
            else if (r[2]) next = 2'b11; // Next state is D if r[2] is high
            else next = 2'b00; // Next state is A if none of the bits of r are high
        end
        2'b01: begin // State B
            if (r[0]) next = 2'b01; // Next state is B if r[0] is high
            else next = 2'b00; // Next state is A otherwise
        end
        2'b10: begin // State C
            if (r[1]) next = 2'b10; // Next state is C if r[1] is high
            else next = 2'b00; // Next state is A otherwise
        end
        2'b11: begin // State D
            if (r[2]) next = 2'b11; // Next state is D if r[2] is high
            else next = 2'b00; // Next state is A otherwise
        end
    endcase
end

assign g[0] = (state == 2'b01); // g[0] is high if current state is B
assign g[1] = (state == 2'b10); // g[1] is high if current state is C
assign g[2] = (state == 2'b11); // g[2] is high if current state is D

endmodule
