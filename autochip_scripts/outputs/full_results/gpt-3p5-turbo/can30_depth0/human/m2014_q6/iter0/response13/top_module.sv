module top_module (
	input clk,
	input reset,
	input w,
	output z
);

    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or w) begin
        case (state)
            3'b000: begin
                if (w) begin
                    next_state = 3'b000;
                end else begin
                    next_state = 3'b001;
                end
            end
            3'b001: begin
                if (w) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b001;
                end
            end
            3'b010: begin
                if (w) begin
                    next_state = 3'b100;
                end else begin
                    next_state = 3'b011;
                end
            end
            3'b011: begin
                if (w) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b100;
                end
            end
            3'b100: begin
                if (w) begin
                    next_state = 3'b100;
                end else begin
                    next_state = 3'b011;
                end
            end
        endcase
    end
    
    assign z = (state == 3'b100);
	
endmodule
