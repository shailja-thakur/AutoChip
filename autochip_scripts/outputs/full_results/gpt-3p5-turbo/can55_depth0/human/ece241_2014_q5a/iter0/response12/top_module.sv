module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [3:0] state, next_state;

parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @* begin
    next_state = state;

    case (state)
        S0: begin
            if (areset == 0) begin
                next_state = S0;
            end else begin
                if (x == 1) begin
                    next_state = S1;
                end
            end
        end

        S1: begin
            if (x == 0) begin
                next_state = S2;
            end
        end

        S2: begin
            if (x == 0) begin
                next_state = S2;
            end else begin
                next_state = S3;
            end
        end

        S3: begin
            if (x == 0) begin
                next_state = S3;
            end else begin
                next_state = S2;
            end
        end
    endcase
end

assign z = (state == S1 || state == S3) ? ~x : x;

endmodule
