module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg z_next;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= 3'b000;
        z <= 1'b0;
    end else begin
        case(state)
            3'b000: begin // State 0
                if (x) begin
                    state <= 3'b001;
                end else begin
                    state <= 3'b000;
                end
            end
            3'b001: begin // State 1
                if (x) begin
                    state <= 3'b010;
                end else begin
                    state <= 3'b000;
                end
            end
            3'b010: begin // State 2
                if (x) begin
                    state <= 3'b001;
                end else begin
                    state <= 3'b011;
                end
            end
            3'b011: begin // State 3 (Final state)
                if (x) begin
                    state <= 3'b010;
                end else begin
                    state <= 3'b000;
                end
            end
        endcase
        if (state == 3'b011) begin // Final state reached
            z_next <= 1'b1;
        end else begin
            z_next <= 1'b0;
        end
    end
end

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        z <= 1'b0;
    end else begin
        z <= z_next;
    end
end

endmodule
