module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

reg [1:0] curr_state;

always @(*) begin
    case(state)
        2'b00: begin
            if(in)
                next_state = 2'b10;
            else
                next_state = 2'b00;
        end
        2'b01: begin
            if(in)
                next_state = 2'b01;
            else
                next_state = 2'b10;
        end
        2'b10: begin
            if(in)
                next_state = 2'b11;
            else
                next_state = 2'b00;
        end
        2'b11: begin
            if(in)
                next_state = 2'b10;
            else
                next_state = 2'b01;
        end
    endcase
end

always @(posedge clk) begin
    curr_state <= state;
    state <= next_state;
end

assign out = (curr_state == 2'b11);

endmodule
