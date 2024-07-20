module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] sum;

// Moore state machine states
localparam [2:0] S_RESET = 3'b000;
localparam [2:0] S_COMPLEMENT = 3'b001;

reg [2:0] state;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= S_RESET;
        count <= 0;
        sum <= 0;
    end else begin
        case (state)
            S_RESET: begin
                if (areset == 1) begin
                    state <= S_COMPLEMENT;
                end
            end
            S_COMPLEMENT: begin
                if (count == 7) begin
                    state <= S_RESET;
                end else begin
                    count <= count + 1;
                    sum <= sum + (~x[count]);
                end
            end
            default: state <= S_RESET;
        endcase
    end
end

assign z = sum;

endmodule
