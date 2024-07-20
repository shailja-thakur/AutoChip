module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b1;
    else begin
        case(state)
            2'b00: 
                if (in) state <= 2'b00;
                else state <= 2'b01;
            2'b01: 
                if (in) state <= 2'b00;
                else state <= 2'b01;
        endcase
    end
end

always @(state) begin
    case(state)
        2'b00: out <= 0;
        2'b01: out <= 1;
    endcase
end

endmodule
