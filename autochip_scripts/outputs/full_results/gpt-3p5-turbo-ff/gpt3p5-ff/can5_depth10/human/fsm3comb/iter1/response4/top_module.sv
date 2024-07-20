module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(state, in) begin
    case (state)
        2'b00: begin
            if (in) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
            out = 1'b0;
        end
        
        2'b01: begin
            if (in) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b01;
            end
            out = 1'b0;
        end
        
        2'b10: begin
            if (in) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b11;
            end
            out = 1'b0;
        end
        
        2'b11: begin
            if (in) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b01;
            end
            out = 1'b1;
        end
    endcase
end

endmodule
