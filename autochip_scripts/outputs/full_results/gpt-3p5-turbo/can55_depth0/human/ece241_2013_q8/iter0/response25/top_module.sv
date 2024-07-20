module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg [2:0] count;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= S0;
    else begin
        case (state)
            S0: begin
                if (x == 1'b1)
                    count <= count + 1;
                else
                    count <= 3'b000;
                if (count == 3'b101)
                    state <= S1;
                else
                    state <= S0;
            end
            S1: begin
                state <= S2;
                count <= 3'b000;
            end
            S2: begin
                state <= S0;
                count <= 3'b000;
            end
        endcase
    end
end

always @(state) begin
    if (state == S1)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
