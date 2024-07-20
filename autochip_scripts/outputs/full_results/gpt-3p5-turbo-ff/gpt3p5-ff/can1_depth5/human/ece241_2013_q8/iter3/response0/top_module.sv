module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg [2:0] sequence;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= 2'b00;
    else begin
        case (state)
            2'b00: begin
                if (x)
                    state <= 2'b01;
            end
            2'b01: begin
                if (x)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
            2'b10: begin
                if (x)
                    sequence <= {sequence[1:0], 1'b1};
                else
                    state <= 2'b00;
            end
        endcase;
    end
end

always @(posedge clk) begin
    case (state)
        2'b10: begin
            if (sequence == 3'b101)
                z <= 1'b1;
            else
                z <= 1'b0;
        end
        default: begin
            z <= 1'b0;
        end
    endcase;
end

endmodule
