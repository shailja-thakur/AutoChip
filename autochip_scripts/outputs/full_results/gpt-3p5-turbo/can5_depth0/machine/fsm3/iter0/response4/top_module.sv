module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // reset to state A
    end else begin
        state <= next_state;
    end
end

always @(state or in) begin
    case (state)
        2'b00: begin // state A
            if (in) begin
                next_state = 2'b01; // next state B if in = 1
            end else begin
                next_state = 2'b00; // next state A if in = 0
            end
        end
        
        2'b01: begin // state B
            if (in) begin
                next_state = 2'b01; // next state B if in = 1
            end else begin
                next_state = 2'b10; // next state C if in = 0
            end
        end
        
        2'b10: begin // state C
            if (in) begin
                next_state = 2'b11; // next state D if in = 1
            end else begin
                next_state = 2'b00; // next state A if in = 0
            end
        end
        
        2'b11: begin // state D
            if (in) begin
                next_state = 2'b01; // next state B if in = 1
            end else begin
                next_state = 2'b10; // next state C if in = 0
            end
        end
    endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
