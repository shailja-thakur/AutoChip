module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
wire out;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b10; // Initial state is B
    else begin
        case (state)
            2'b10: begin // B state
                if (in)
                    state <= 2'b10; // Next state is B
                else
                    state <= 2'b01; // Next state is A
            end
            2'b01: begin // A state
                if (in)
                    state <= 2'b01; // Next state is A
                else
                    state <= 2'b10; // Next state is B
            end
        endcase
    end
end

assign out = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
