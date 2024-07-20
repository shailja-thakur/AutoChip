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
        else
            case (state)
                2'b00: begin
                    if (x == 1'b1)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end
                2'b01: begin
                    if (x == 1'b0)
                        state <= 2'b10;
                    else
                        state <= 2'b00;
                end
                2'b10: begin
                    if (x == 1'b1)
                        state <= 2'b01;
                    else
                        state <= 2'b10;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b10: sequence <= 3'b101;
            default: sequence <= 3'b000;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            z <= 1'b0;
        else begin
            if (sequence == 3'b101)
                z <= 1'b1;
            else
                z <= 1'b0;
        end
    end
endmodule
