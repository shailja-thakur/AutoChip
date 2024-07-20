module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
reg z_next;

parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
    end else begin
        case (state)
            S0: begin
                if (x) begin
                    state <= S1;
                end else begin
                    state <= S0;
                end
            end
            S1: begin
                if (!x) begin
                    state <= S2;
                end else if (x) begin
                    state <= S1;
                end
            end
            S2: begin
                if (x) begin
                    state <= S1;
                end
            end
            default: state <= S0;
        endcase
    end
end

always @(state, x) begin
    case (state)
        S0, S1: z_next = 0;
        S2: z_next = 1;
        default: z_next = 0;
    endcase
end

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        z <= 0;
    end else begin
        z <= z_next;
    end
end

endmodule
