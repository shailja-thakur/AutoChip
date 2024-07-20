module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    reg [1:0] counter;

    always @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01;
        else if (train_valid && train_taken && (counter < 2'b11))
            counter <= counter + 1;
        else if (train_valid && !train_taken && (counter > 2'b00))
            counter <= counter - 1;
    end

    assign state = counter;

endmodule
