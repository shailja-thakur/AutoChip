module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
); 

    reg [4:0] state, next_state;
    
    always @(posedge clk or negedge aresetn) begin
        if (aresetn === 0) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end
	
    always @(*) begin
        case(state)
            0: begin
                if (x == 0) begin
                    next_state = 0;
                end else if (x == 1) begin
                    next_state = 1;
                end
            end
            1: begin
                if (x == 0) begin
                    next_state = 2;
                end else if (x == 1) begin
                    next_state = 1;
                end
            end
            2: begin
                if (x == 0) begin
                    next_state = 0;
                end else if (x == 1) begin
                    next_state = 1;
                end
            end
            default: begin
                next_state = 0;
            end
        endcase
    end
	
    always @(state) begin
        case(state)
            0: begin
                z = 0;
            end
            1: begin
                z = 0;
            end
            2: begin
                z = x;
            end
            default: begin
                z = 0;
            end
        endcase
    end
	
endmodule
