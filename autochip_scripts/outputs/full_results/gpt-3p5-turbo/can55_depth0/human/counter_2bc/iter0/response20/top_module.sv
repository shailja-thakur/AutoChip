module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    reg [1:0] count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            count <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && count < 2'b11) begin
                count <= count + 1;
            end else if (!train_taken && count > 2'b00) begin
                count <= count - 1;
            end
        end
    end

    assign state = count;

endmodule
