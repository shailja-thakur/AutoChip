module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

    reg [1:0] state;
    reg [1:0] cycle_count;
    reg [1:0] one_count;

    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
            cycle_count <= 0;
            one_count <= 0;
        end else begin
            case (state)
                A: begin
                    if (s == 0) begin
                        state <= A;
                    end else begin
                        state <= B;
                        cycle_count <= 0;
                        one_count <= 0;
                    end
                end
                
                B: begin
                    cycle_count <= cycle_count + 1;
                    if (w == 1)
                        one_count <= one_count + 1;
                    if (cycle_count == 2'b11) begin
                        if (one_count == 2'b10)
                            z <= 1;
                        else
                            z <= 0;
                        cycle_count <= 0;
                        one_count <= 0;
                    end else begin
                        state <= B;
                    end
                end
                
            endcase
        end
    end

endmodule
