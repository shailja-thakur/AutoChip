module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] count;
reg [7:0] sum;
reg state;

always @(posedge clk or negedge areset)
begin
    if (areset==1)
        state <= 0;
    else
    begin
        case(state)
            0: 
                begin
                    if(x==1)
                    begin
                        count <= 1;
                        sum <= !x;
                        state <= 1;
                    end
                    else
                    begin
                        count <= 0;
                        sum <= x;
                        state <= 0;
                    end
                end
            1:
                begin
                    if(count<7)
                    begin
                        count <= count + 1;
                        sum <= x;
                        state <= 1;
                    end
                    else
                    begin
                        count <= 0;
                        sum <= x;
                        state <= 0;
                    end
                end
        endcase
    end
end

assign z = sum;

endmodule
