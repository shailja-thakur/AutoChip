module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state;
    reg [2:0] sequence;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= 2'b00;
        else
            case (state)
                2'b00:
                    if (x == 1'b1)
                        state <= 2'b01;
                2'b01:
                    if (x == 1'b0)
                        state <= 2'b10;
                    else if (x == 1'b1)
                        state <= 2'b01;
                2'b10:
                    if (x == 1'b0)
                        state <= 2'b00;
                    else if (x == 1'b1) begin
                        state <= 2'b01;
                        if (sequence == 3'b101)
                            z <= 1'b1;
                        else
                            z <= 1'b0;
                    end
            endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            sequence <= 3'b000;
        else if (state == 2'b01)
            sequence <= {sequence[1:0], x};
        else if (state == 2'b10)
            sequence <= {x, sequence[2]};
    end

endmodule
