module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [7:0] sum;
reg [7:0] two_complement;

enum [2:0] state = {S0, S1};

reg [2:0] current_state, next_state;
reg enable_conversion;

always @(posedge clk or posedge areset) begin
    if(areset)
        current_state <= S0;
    else
        current_state <= next_state;
end

always @(current_state or x) begin
    case(current_state)
        S0: begin
            if(~areset)
                enable_conversion <= 1;
            else
                enable_conversion <= 0;
            
            sum <= 0;
            if(enable_conversion)
                two_complement <= ~x + 1;
        end
        
        S1: begin
            if(enable_conversion)
                two_complement <= sum + x;
        end
    endcase
end

always @(current_state) begin
    case(current_state)
        S0: begin
            next_state <= S1;
        end
        
        S1: begin
            if(enable_conversion)
                next_state <= S0;
            else
                next_state <= S1;
        end
    endcase
end

assign z = enable_conversion ? ~two_complement + 1 : 0;

endmodule
