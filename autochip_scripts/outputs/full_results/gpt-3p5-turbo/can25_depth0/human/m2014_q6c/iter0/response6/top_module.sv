module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
    wire Y2_temp;
    wire Y4_temp;

    assign Y2 = Y2_temp;
    assign Y4 = Y4_temp;

    always @(*) begin
        case(y)
            6'b000001: begin
                if(w == 1'b0) begin
                    Y2_temp = 1'b1;
                    Y4_temp = 1'b0;
                end else begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end
            end
            6'b000010: begin
                if(w == 1'b0) begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b0;
                end else begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end
            end
            6'b000100: begin
                if(w == 1'b0) begin
                    Y2_temp = 1'b1;
                    Y4_temp = 1'b0;
                end else begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end
            end
            6'b001000: begin
                if(w == 1'b0) begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b0;
                end else begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end
            end
            6'b010000: begin
                if(w == 1'b0) begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end else begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end
            end
            6'b100000: begin
                if(w == 1'b0) begin
                    Y2_temp = 1'b1;
                    Y4_temp = 1'b0;
                end else begin
                    Y2_temp = 1'b0;
                    Y4_temp = 1'b1;
                end
            end
            default: begin
                Y2_temp = 1'b0;
                Y4_temp = 1'b0;
            end
        endcase
    end

endmodule
