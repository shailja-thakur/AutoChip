module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    reg [2:0] state;
    reg [2:0] next_state;
    reg [3:0] count;
    reg [3:0] next_count;
    reg [3:0] complement;
    reg [3:0] next_complement;
    wire reset_trigger;
    
    assign reset_trigger = ~areset;
    
    always @(posedge clk or posedge reset_trigger) begin
        if(reset_trigger) begin
            state <= 3'b000;
            count <= 4'b0000;
        end
        else begin
            state <= next_state;
            count <= next_count;
        end
    end
    
    always @(state, count, x) begin
        case(state)
            3'b000: begin
                if(count == 4'b0001) next_state = 3'b001;
                else next_state = 3'b000;
                
                if(count == 4'b0001) next_count = 4'b0000;
                else next_count = count + 1;
                
                if(x == 1'b0) next_complement = count + 1;
                else next_complement = complement;
            end
            
            3'b001: begin
                next_state = 3'b010;
                next_count = count + 1;
                next_complement = complement + 1;
            end
            
            3'b010: begin
                if(count == 4'b1111) next_state = 3'b000;
                else next_state = 3'b010;
                
                next_count = count + 1;
                next_complement = complement + 1;
            end
        endcase
    end
    
    assign z = complement;
    
endmodule
