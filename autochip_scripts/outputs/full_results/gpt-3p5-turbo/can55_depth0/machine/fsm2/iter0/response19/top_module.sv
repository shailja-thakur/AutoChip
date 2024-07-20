module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state;

    always @ (posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b00;
        else
            state <= (state == 2'b00 && j) ? 2'b01 :
                     (state == 2'b01 && k) ? 2'b00 :
                     state;
    end

    assign out = (state == 2'b01);
      
endmodule
