module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;

// Combinational logic for determining the next state
always @ (state or in) begin
    case(state)
        2'b00: // state A
            if(in) begin
                next_state = 2'b01; // state B
            end
            else begin
                next_state = 2'b00; // state A
            end
            
        2'b01: // state B
            if(in) begin
                next_state = 2'b01; // state B
            end
            else begin
                next_state = 2'b10; // state C
            end
            
        2'b10: // state C
            if(in) begin
                next_state = 2'b11; // state D
            end
            else begin
                next_state = 2'b00; // state A
            end
            
        2'b11: // state D
            if(in) begin
                next_state = 2'b01; // state B
            end
            else begin
                next_state = 2'b10; // state C
            end
    endcase
end

// Sequential logic for updating the state
always @ (posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // reset to state A
    end
    else begin
        state <= next_state; // update state
    end
end

// Output logic
assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
