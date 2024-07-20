module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        3'b000: begin
            if (x == 1'b1) begin
                next_state = 3'b001;
            end else begin
                next_state = 3'b000;
            end
        end
        3'b001: begin
            next_state = 3'b010;
        end
        3'b010: begin
            next_state = 3'b011;
        end
        3'b011: begin
            next_state = 3'b001;
        end
        default: begin
            next_state = 3'b000;
        end
    end
end

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        z <= 1'b0;
    end else begin
        case (state)
            3'b000: begin
                z <= 1'b0;
            end
            3'b001: begin
                z <= 1'b1;
            end
            3'b010: begin
                z <= 1'b0;
            end
            3'b011: begin
                z <= 1'b1;
            end
            default: begin
                z <= 1'b0;
            end
        end
    end
end

endmodule
