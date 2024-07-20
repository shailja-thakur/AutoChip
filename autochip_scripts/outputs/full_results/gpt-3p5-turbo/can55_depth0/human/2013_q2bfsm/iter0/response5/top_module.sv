module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
    reg f;
    reg g;
    reg [1:0] state;
    wire x_delay_1;
    wire x_delay_2;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            f <= 0;
            g <= 0;
            state <= 2'b00; // State A
        end else begin
            case (state)
                2'b00: begin // State A
                    f <= 0;
                    g <= 0;
                    
                    if (~resetn) begin
                        state <= 2'b00; // State A
                    end else begin
                        state <= 2'b01; // State B
                    end
                end
                2'b01: begin // State B
                    if (~resetn) begin
                        f <= 1;
                        state <= 2'b10; // State C
                    end else begin
                        f <= 0;
                    end
                end
                2'b10: begin // State C
                    if (x_delay_2 & ~x_delay_1 & x) begin
                        state <= 2'b11; // State D
                    end else if (~resetn) begin
                        state <= 2'b00; // State A
                    end else begin
                        state <= 2'b10; // State C
                    end
                end
                2'b11: begin // State D
                    g <= 1;
                    if (y) begin
                        state <= 2'b11; // State D
                    end else if (~resetn) begin
                        state <= 2'b00; // State A
                    end else begin
                        state <= 2'b10; // State C
                    end
                end
            endcase
        end
    end
    
    assign x_delay_1 = #1 x;
    assign x_delay_2 = #2 x_delay_1;

endmodule
